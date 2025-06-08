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

    func saveDogs(_ dogs: [Dog]) async throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = DogEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        
        for dog in dogs {
            let entity = DogEntity(context: context)
            entity.fill(from: dog)
        }
        
        try self.context.save()
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
