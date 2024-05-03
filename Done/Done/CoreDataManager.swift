//
//  CoreDataManager.swift
//  Done
//
//  Created by Rishi Venkat on 11/24/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "Done")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}

