//
//  PersistenceController.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 4 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import CoreData

struct PersistenceController
{
    let container: NSPersistentContainer
    
    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(_ name: String, inMemory: Bool = false)
    {
        container = NSPersistentContainer(name: name)
        if inMemory
        {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores
        { (storeDescription, error) in
            
            if let error = error as NSError?
            {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    @discardableResult
    func save() -> Bool
    {
        if container.viewContext.hasChanges
        {
            do
            {
                try container.viewContext.save()
            }
            catch
            {
                return false
            }
        }
        
        return true
    }
}

extension PersistenceController
{
    static var favorites: Self = .init("FavoritesModel")
}
