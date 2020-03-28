//
//  Person+CoreDataProperties.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 26.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var lastname: String?
    @NSManaged public var name: String?
    @NSManaged public var attributes: NSOrderedSet?

}

// MARK: Generated accessors for attributes
extension Person {

    @objc(insertObject:inAttributesAtIndex:)
    @NSManaged public func insertIntoAttributes(_ value: Attributes, at idx: Int)

    @objc(removeObjectFromAttributesAtIndex:)
    @NSManaged public func removeFromAttributes(at idx: Int)

    @objc(insertAttributes:atIndexes:)
    @NSManaged public func insertIntoAttributes(_ values: [Attributes], at indexes: NSIndexSet)

    @objc(removeAttributesAtIndexes:)
    @NSManaged public func removeFromAttributes(at indexes: NSIndexSet)

    @objc(replaceObjectInAttributesAtIndex:withObject:)
    @NSManaged public func replaceAttributes(at idx: Int, with value: Attributes)

    @objc(replaceAttributesAtIndexes:withAttributes:)
    @NSManaged public func replaceAttributes(at indexes: NSIndexSet, with values: [Attributes])

    @objc(addAttributesObject:)
    @NSManaged public func addToAttributes(_ value: Attributes)

    @objc(removeAttributesObject:)
    @NSManaged public func removeFromAttributes(_ value: Attributes)

    @objc(addAttributes:)
    @NSManaged public func addToAttributes(_ values: NSOrderedSet)

    @objc(removeAttributes:)
    @NSManaged public func removeFromAttributes(_ values: NSOrderedSet)

}
