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

    func saveDogs(_ dogs: [DogDTO]) async {
        await context.perform {
            dogs.forEach { dog in
                let entity = DogEntity(context: self.context)
                entity.dogDescription = dog.description ?? ""
                entity.dogName = dog.dogName ?? ""
                entity.age = Int16(dog.age ?? 0)
                entity.image = dog.image ?? ""
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
            fetchRequest.resultType = .managedObjectResultType // ✅ <-- clave
            fetchRequest.includesPropertyValues = false
            fetchRequest.includesPendingChanges = false
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeStatusOnly
            _ = try? self.context.execute(batchDeleteRequest)
            try? self.context.save()
        }
    }

}
