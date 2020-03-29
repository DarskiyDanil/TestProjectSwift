//
//  EditListViewController.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData

class EditListViewController: UITableViewController, ExpandebleEditListHeaderFooterViewDelegate {
    
    var personCoreData: [Person]?
    static let shared = EditListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationBarAdd()
        }
        tableView.indicatorStyle = .default
        tableView.backgroundColor = .white
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: EditTableViewCell.idCell)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        получаем сохраненные сущности
        let context = getContext()
        //        запрос
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            personCoreData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        убрал палец с ячейки и снял выделение
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    высота секции
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    //    высота ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    //    установка вида для нижнего колонтитула
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 4))
        footerView.backgroundColor = .white
        return footerView
    }
    
    //    толщина разделительной линии между ячейками
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    //    внешний вид секции
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandebleEditListHeaderFooterView()
        guard let name = personCoreData![section].name else {return header}
        header.setupSection(withTitle: name, section: section, delegate: self)
        header.buttonAdd.tag = section
        header.dellOnePersonButton.tag = section
        return header
    }
    
    //    количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return personCoreData?.count ?? 0
    }
    
    //    количество ячеек в секциях
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personCoreData?[section].attributes?.count ?? 0
    }
    
    //    ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditTableViewCell.idCell, for: indexPath) as! EditTableViewCell
        guard let attribute = personCoreData?[indexPath.section].attributes?[indexPath.row] as? Attributes,
            let attribut = attribute.attributePerson else {return cell}
        cell.textInCell.text = attribut
        return cell
    }
    
}


extension EditListViewController: UITextViewDelegate {
    
    // MARK: - CoreData
    
    //    удаление ячеек свайпом
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            //            удаление в массиве
            let context = self.getContext()
            guard let person = self.personCoreData else {return}
            guard let attributes = person[indexPath.section].attributes  else {return}
            guard let attribut = attributes[indexPath.row] as? Attributes else {return}
            context.delete(attribut)
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            //  перезагрузка таблицы
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemPink
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    // получаем контекст CoreData
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataManager.persistentContainer.viewContext
    }
    
    //    добавить секцию с Person
    private func saveSectionPersonTitleName(wiithTitleName: String) {
        let context = getContext()
        // объект Person
        let personObject = Person(context: context)
        // помещаем имя Person секции в объект
        personObject.name = wiithTitleName
        // сохранение
        do {
            try context.save()
            personCoreData!.append(personObject)
        } catch let error as NSError {
            print("метод saveSectionPersonTitleName не сохранил: \(error.localizedDescription)")
        }
    }
    
    //    добавить атрибуты в секцию Person
    func saveAttributesPersonTitleName (wiithAttributesPerson: String, section: Int) {
        let context = getContext()
        // получаем объект Attributes в контексте
        let contextObject = Attributes(context: context)
        //        сохраняем конкретный атрибут
        contextObject.attributePerson = wiithAttributesPerson
        //        копия массива объекта Person
        let attributes = personCoreData?[section].attributes?.mutableCopy() as? NSMutableOrderedSet
        //         добавление одного атрибута
        attributes?.add(contextObject)
        //        присваиваем Person новый Attributes
        self.personCoreData?[section].attributes = attributes
        do {
            try context.save()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print("метод saveSectionPersonTitleName не сохранил: \(error.localizedDescription)")
        }
    }
    
    // MARK: - @objc func
    
    //    добавить секцию с Person
    @objc func tapAddOnePersonButton() {
        let alertController = UIAlertController(title: "Новый персонаж", message: "Введите имя:", preferredStyle: .alert)
        let save = UIAlertAction(title: "сохранить", style: .default) { (action) in
            let texF = alertController.textFields?.first
            if let newPerson = texF!.text {
                self.saveSectionPersonTitleName(wiithTitleName: newPerson)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "закрыть", style: .default) { _ in }
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //    добавить ячейку для Person
    @objc func tapAddCellInSectionButton (buttonTag: UIButton) {
        let section = buttonTag.tag
        let alertController = UIAlertController(title: "Новый атрибут", message: "Введите текст:", preferredStyle: .alert)
        let save = UIAlertAction(title: "сохранить", style: .default) { (action) in
            let texF = alertController.textFields?.first
            if let newPerson = texF?.text {
                self.saveAttributesPersonTitleName(wiithAttributesPerson: newPerson, section: section)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "закрыть", style: .default) { _ in }
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // удаление объектов Person кнопкой
    @objc func tapDellOnePersonButton (buttonTag: UIButton) {
        let section = buttonTag.tag
        let context = getContext()
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        //        получаем все Person
        if let objects = try? context.fetch(fetchRequest) {
            let object = objects[section]
            context.delete(object)
        }
        do {
            try context.save()
            personCoreData?.remove(at: section)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Constraint
    
    //    настройка navigationBar
    func navigationBarAdd() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "список людей"
        let addOnePersonButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.plus"), style: .done, target: self, action: #selector(tapAddOnePersonButton))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItems = [addOnePersonButton]
    }
}
