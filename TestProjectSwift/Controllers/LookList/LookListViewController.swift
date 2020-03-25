//
//  LookListViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class LookListViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegateFlowLayout, ExpandebleLookListHeaderFooterViewDelegate {
    
    static let shared = LookListViewController()
    
    let editListViewController = EditListViewController()
    let datasource = LookListDataSource()
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        DispatchQueue.main.async {
            self.addTableView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //    убрал палец с ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    высота секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    //    высота ячейки в зависимости от нажатой секции
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datasource.sectionsPerson[indexPath.section].toggleExpanded {
            return 45
        }
        return 0
    }
    
    // установка вида для нижнего колонтитула
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 4))
        footerView.backgroundColor = .white
        return footerView
    }
    
    //    толщина разделительной линии между ячейками
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    //    внешний вид секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandebleLookListHeaderFooterView()
        header.setupSection(withTitle: datasource.sectionsPerson[section].namePerson + "  " + datasource.sectionsPerson[section].lastnamePerson, section: section, delegate: self)
        return header
    }
    
    //    при нажатии на секцию
    func toggleSection(header: ExpandebleLookListHeaderFooterView, section: Int) {
        //        меняем
        datasource.sectionsPerson[section].toggleExpanded = !datasource.sectionsPerson[section].toggleExpanded
        
        //        меняем цвет секции
        if datasource.sectionsPerson[section].toggleExpanded == true {
            header.view.backgroundColor = #colorLiteral(red: 0.7395023704, green: 0.8710801601, blue: 1, alpha: 1)
        } else {
            header.view.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        }
        
        //        обновление строк относящихся к секции
        tableView.beginUpdates()
        for row in 0..<datasource.sectionsPerson[section].attributePerson.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    
//    //    удаление ячеек свайпом
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "") { _, _, completionHandler in
//
//            // 1. remove object from your array
//            self.datasource.sectionsPerson.remove(at: indexPath.section)
//            // 2. reload the table, otherwise you get an index out of bounds crash
//            self.tableView.reloadData()
//
//            completionHandler(true)
//        }
//        deleteAction.backgroundColor = .systemGreen
//        deleteAction.image = UIImage(named: "trash")
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
    
}


extension LookListViewController {
    
    // MARK: Constraint
    
    func addTableView() {
        
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.register(LookListTableViewCell.self, forCellReuseIdentifier: LookListTableViewCell.idCell)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.indicatorStyle = .default
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
//    застрял здесь
    @objc func tapButtonCorrect() {
//        navigationController?.pushViewController(self.editListViewController, animated: false)
        navigationController?.present(self.editListViewController, animated: true, completion: nil)
        print("tapButtonCorrect")
    }
    
}
