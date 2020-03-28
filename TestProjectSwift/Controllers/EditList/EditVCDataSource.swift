//
//  EditVCDataSource.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 13.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import CoreData

//class EditVCDataSource: UITableView, UITableViewDataSource, UITableViewDelegate {
//    
//    var attribut: [Attributes] = []
//    var personCoreData: [Person]?
//    var onePerson: /*[Person] = []*/
//        [SectionPerson] = [SectionPerson(namePerson: "Николай", lastnamePerson: "Николаевич", attributePerson: [
//        "редактируемая информация", "в процессе разработки", "почти у цели"
//    ], toggleExpanded: false)]
//    
//    //    количество секций
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return onePerson.count
//    }
//    
//    //    количество ячеек в секциях
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return onePerson[section].attributePerson.count
////        return onePerson[section].attributes?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: EditTableViewCell.idCell, for: indexPath) as! EditTableViewCell
//        cell.textInCell.text = onePerson[indexPath.section].attributePerson[indexPath.row]
//
////        let dcw = NSSet(objects: attribut[indexPath.row].attributePerson!)
////        cell.textInCell.text = dcw.description //неверно
//        
//        return cell
//    }
//    
//}
