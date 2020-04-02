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
    let dataSource = LookListDataSource()
    
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        DispatchQueue.main.async {
            self.addTableView()
        }
        returnCoreData()
        //        прием уведомления
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func returnCoreData() {
        //        получаем сохраненные сущности
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            dataSource.personCoreData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //    метод уведомления для обновления tableView
    @objc func reloadTableData(_ notification: Notification) {
        DispatchQueue.main.async {
            self.returnCoreData()
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
        guard let person = dataSource.personCoreData?[indexPath.section] else {return 0}
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
        guard let name = dataSource.personCoreData![section].name else {return header}
        header.setupSection(withTitle: name, section: section, delegate: self)
        return header
    }
    
    //    при нажатии на секцию
    func toggleSection(header: ExpandebleLookListHeaderFooterView, section: Int) {
        //        меняем
         dataSource.personCoreData?[section].toggleExpanded = !(dataSource.personCoreData?[section].toggleExpanded)!
        //        обновление строк относящихся к секции
        tableView.beginUpdates()
        guard let attribut = dataSource.personCoreData?[section].attributes else {return}
        for row in 0..<attribut.count {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
            }
//            self.tableView.reloadSectionIndexTitles()
        }
//        self.tableView.reloadSectionIndexTitles()
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
    }
    
    //    MARK: - Constraint
    
    //    размещение tableView
    func addTableView() {
        
        tableView.backgroundColor = .white
        tableView.register(LookListTableViewCell.self, forCellReuseIdentifier: LookListTableViewCell.idCell)
        tableView.dataSource = dataSource
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
