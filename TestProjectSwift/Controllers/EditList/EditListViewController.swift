//
//  EditListViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class EditListViewController: UIViewController, UITableViewDelegate, ExpandebleEditListHeaderFooterViewDelegate {
    
    static let shared = EditListViewController()
    let datasource = EditVCDataSource()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
let toolBar =  UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bundle.barStyle = .default
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
        //        if datasource.onePerson[indexPath.section].toggleExpanded {
        //            return 45
        //        }
        return 45
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
        let header = ExpandebleEditListHeaderFooterView()
        header.setupSection(withTitle: datasource.onePerson[section].namePerson + "  " + datasource.onePerson[section].lastnamePerson, section: section, delegate: self)
        return header
    }
    
    //    при нажатии на секцию
    func toggleSection(header: ExpandebleEditListHeaderFooterView, section: Int) {
        //        меняем
        datasource.onePerson[section].toggleExpanded = !datasource.onePerson[section].toggleExpanded
        
        //        меняем цвет секции
        if datasource.onePerson[section].toggleExpanded == true {
            header.view.backgroundColor = #colorLiteral(red: 0.7395023704, green: 0.8710801601, blue: 1, alpha: 1)
        } else {
            header.view.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        }
        
        //        обновление строк относящихся к секции
        tableView.beginUpdates()
        for row in 0..<datasource.onePerson[section].attributePerson.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    //    удаление ячеек свайпом
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            //  удаление в массиве
            self.datasource.onePerson[indexPath.section].attributePerson.remove(at: indexPath.row)
            //  перезагрузка таблицы
            self.tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemPink
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}


extension EditListViewController {
    
    // MARK: Constraint
    
    func addTableView() {
        

    view.addSubview(toolBar)
    view.addSubview(tableView)


        
        tableView.backgroundColor = .white
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: EditTableViewCell.idCell)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.indicatorStyle = .default
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.topAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.toolBar.barStyle = .default
        self.toolBar.isTranslucent = true
        self.toolBar.backgroundColor = #colorLiteral(red: 0.910679996, green: 0.8889362812, blue: 1, alpha: 1)
        self.toolBar.tintColor = .systemBlue
        self.toolBar.sizeToFit()
            
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        toolBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        toolBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        //        настройка кнопок
        let savePersonImage = UIImage(systemName: "checkmark.rectangle")
        let addOnePersonImage = UIImage(systemName: "person.crop.circle.badge.plus")
//        let aboutProgrammImageForButton = UIImage(systemName: "checkmark.rectangle")
        
        let savePersonsListButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapSavePersonsListButton))
        savePersonsListButton.image = savePersonImage
        
        let addOnePersonButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapAddOnePersonButton))
        addOnePersonButton.image = addOnePersonImage
        
//        let aboutProgrammButton = UIBarButtonItem(title: nil, style: .done, target: self, action: #selector (tapDellOnePersonButton))
//        aboutProgrammButton.image = aboutProgrammImageForButton
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolBar.setItems([addOnePersonButton, flexibleSpace, savePersonsListButton], animated: false)
        self.toolBar.isUserInteractionEnabled = true
    }
    
//    добавить ячейку для Person
    @objc func tapAddCellInSectionButton () {
    //        navigationController?.present(EditListViewController(), animated: true, completion: nil)
        print("tapAddCellInSectionButton")
        }
    
    // сохранение изменений
    @objc func tapSavePersonsListButton () {
//        navigationController?.present(EditListViewController(), animated: true, completion: nil)
        print("tapSavePersonsListButton")
    }

//    добавить секцию с Person
    @objc func tapAddOnePersonButton () {
        print("tapAddOnePersonButton")
//        navigationController?.present(LookListViewController(), animated: true, completion: nil)
    }

    
    @objc func tapDellOnePersonButton () {
        print("tapDellOnePersonButton")
    }
    
}


