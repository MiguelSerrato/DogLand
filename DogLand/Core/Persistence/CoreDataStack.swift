//
//  CoreDataStack.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import CoreData
import Foundation

class CoreDataStack {
    static func inMemoryStack() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "DataModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }

        return container
    }

    static let shared: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
        }
        return container
    }()
}
