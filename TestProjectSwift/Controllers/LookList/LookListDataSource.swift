//
//  LookListDataSource.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData

class LookListDataSource: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var sectionsPerson: [SectionPerson] = [
        SectionPerson(namePerson: "Василий", lastnamePerson: "Васильевич", attributePerson: [
            "вредные привычки - нет", "возраст: 55", "женат"
        ], toggleExpanded: false),
        SectionPerson(namePerson: "Пётр", lastnamePerson: "Петрович", attributePerson: [
            "здесь может быть", "Ваша", "Реклама"
        ], toggleExpanded: false),
        SectionPerson(namePerson: "Олег", lastnamePerson: "Олегович", attributePerson: [
            "сотрудник Lays", "в отпуске"
        ], toggleExpanded: false),
        SectionPerson(namePerson: "Денис", lastnamePerson: "Денисович", attributePerson: [
            "позвонить", "по вопросам аренды"
        ], toggleExpanded: false)
    ]
    
    //    количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsPerson.count
    }
    
    //    количество ячеек в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsPerson[section].attributePerson.count
    }
    
    //     настройка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LookListTableViewCell.idCell, for: indexPath) as! LookListTableViewCell
        cell.textLabel?.text = sectionsPerson[indexPath.section].attributePerson[indexPath.row]
        return cell
    }
    
}
