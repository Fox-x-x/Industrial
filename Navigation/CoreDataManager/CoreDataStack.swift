//
//  CoreDataStack.swift
//  Navigation
//
//  Created by Pavel Yurkov on 29.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    static var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavPostModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError()
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return CoreDataStack.persistentStoreContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return CoreDataStack.persistentStoreContainer.newBackgroundContext()
    }
    
    func save(context: NSManagedObjectContext) {
        context.perform {
            if context.hasChanges {
                 do {
                     try context.save()
                 } catch {
                     print(error.localizedDescription)
                 }
             }
        }
    }
    
    func createObject<P: NSManagedObject> (from entity: P.Type, with context: NSManagedObjectContext) -> P {
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! P
        return object
    }
    
    func delete(object: NSManagedObject, with context: NSManagedObjectContext) {
        context.delete(object)
        save(context: context)
    }
    
    func fetchData<P: NSManagedObject>(for entity: P.Type, with context: NSManagedObjectContext) -> [P] {
        let request = entity.fetchRequest() as! NSFetchRequest<P>
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data from context")
            fatalError()
        }
    }
    
    func fetchDataWithRequest<P: NSManagedObject>(for entity: P.Type, with context: NSManagedObjectContext, request: NSFetchRequest<P>) -> [P] {
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data from context")
            fatalError()
        }
    }
}
