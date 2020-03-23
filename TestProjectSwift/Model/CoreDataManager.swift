//
//  CoreDataManager.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 14.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersonModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    // MARK: - CRUD
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainPerson() -> Person {
        let person = Person(context: viewContext)
        let attributes = Attributes(context: viewContext)
        attributes.attributePerson = ""
        person.name = ""
        person.attributes = [attributes]
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return person
    }
    
}
