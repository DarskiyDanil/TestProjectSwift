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
    
    var personCoreData: [Person]?
    
    //    количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return personCoreData?.count ?? 0
    }
    
    //    количество ячеек в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personCoreData?[section].attributes?.count ?? 0
    }
    
    //     настройка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LookListTableViewCell.idCell, for: indexPath) as! LookListTableViewCell
        guard let attribute = personCoreData?[indexPath.section].attributes?[indexPath.row] as? Attributes,
        let attribut = attribute.attributePerson else {return cell}
        cell.textLabel?.text = attribut
        return cell
    }
    
}
