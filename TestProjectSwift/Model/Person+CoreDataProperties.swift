//
//  Person+CoreDataProperties.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 14.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var attributes: NSSet?

}

// MARK: Generated accessors for attributes
extension Person {

    @objc(addAttributesObject:)
    @NSManaged public func addToAttributes(_ value: Attributes)

    @objc(removeAttributesObject:)
    @NSManaged public func removeFromAttributes(_ value: Attributes)

    @objc(addAttributes:)
    @NSManaged public func addToAttributes(_ values: NSSet)

    @objc(removeAttributes:)
    @NSManaged public func removeFromAttributes(_ values: NSSet)

}
