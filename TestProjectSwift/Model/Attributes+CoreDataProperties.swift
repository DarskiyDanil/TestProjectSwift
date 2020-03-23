//
//  Attributes+CoreDataProperties.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 14.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension Attributes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attributes> {
        return NSFetchRequest<Attributes>(entityName: "Attributes")
    }

    @NSManaged public var attributePerson: String?
    @NSManaged public var peron: Person?

}
