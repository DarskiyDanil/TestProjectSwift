//
//  LookListViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData

// создал имя нотификации
extension Notification.Name {
    static let reload = Notification.Name("reload")
}

class LookListViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegateFlowLayout, ExpandebleLookListHeaderFooterViewDelegate {
    
    static let shared = LookListViewController()
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
        //        прием уведомления
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        получаем сохраненные сущности
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        //        сортировка
        do {
            datasource.personCoreData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //    метод уведомления для обновления tableView
    @objc func reloadTableData(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        guard let person = datasource.personCoreData?[indexPath.section] else {return 0}
        if person.toggleExpanded {
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
        guard let name = datasource.personCoreData![section].name else {return header}
        header.setupSection(withTitle: name, section: section, delegate: self)
        return header
    }
    
    //    при нажатии на секцию
    func toggleSection(header: ExpandebleLookListHeaderFooterView, section: Int) {
        //        меняем
        datasource.personCoreData?[section].toggleExpanded = !(datasource.personCoreData?[section].toggleExpanded)!
        //        меняем цвет секции
        if datasource.personCoreData?[section].toggleExpanded == true {
            header.view.backgroundColor = #colorLiteral(red: 0.7395023704, green: 0.8710801601, blue: 1, alpha: 1)
        } else {
            header.view.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        }
        //        обновление строк относящихся к секции
        tableView.beginUpdates()
        guard let person = datasource.personCoreData?[section] else {return}
        guard let attribut = person.attributes else {return}
        for row in 0..<attribut.count {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
            }
        }
        tableView.endUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}


extension LookListViewController {
    
    // MARK: - CoreData
    
    // получаем контекст CoreData
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataManager.persistentContainer.viewContext
    }
    
    // MARK: - @objc func
    
    //    нажатие кнопки для редактирования с переходом в EditList
    @objc func tapButtonCorrect() {
        let editListViewController = EditListViewController()
        editListViewController.modalPresentationStyle = .popover
        editListViewController.modalTransitionStyle = .crossDissolve
        editListViewController.isModalInPresentation = false
        present(editListViewController, animated: true, completion: nil)
        //                navigationController?.pushViewController(EditListViewController(), animated: true)
    }
    
    //    MARK: - Constraint
    
    //    размещение tableView
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
    
}
