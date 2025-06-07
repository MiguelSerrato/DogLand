//
//  CoreDataDogDataSourceImpl.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import CoreData
import Foundation

class CoreDataDogDataSourceImpl: CoreDataDogDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveDogs(_ dogs: [Dog]) async {
        await context.perform {
            dogs.forEach { [weak self] dog in
                if let self = self {
                    let fetch = DogEntity.fetchRequest()
                    fetch.predicate = NSPredicate(format: "dogId == %@", dog.id)
                    
                    if let existing = try? self.context.fetch(fetch).first {
                        existing.fill(from: dog)
                    } else {
                        let entity = DogEntity(context: self.context)
                        entity.fill(from: dog)
                    }
                }
                
            }
            try? self.context.save()
        }
    }

    func fetchDogs() async -> [Dog] {
        await context.perform {
            let request = DogEntity.fetchRequest()
            let result = try? self.context.fetch(request)
            return result?.compactMap { entity in
                Dog(
                    name: entity.dogName ?? "",
                    age: Int(entity.age),
                    description: entity.dogDescription ?? "",
                    image: entity.image ?? ""
                )
            } ?? []
        }
    }
    
    func deleteAllDogs() async {
        await context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogEntity")
            fetchRequest.resultType = .managedObjectResultType
            fetchRequest.includesPropertyValues = false
            fetchRequest.includesPendingChanges = false
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeStatusOnly
            _ = try? self.context.execute(batchDeleteRequest)
            try? self.context.save()
        }
    }

}
