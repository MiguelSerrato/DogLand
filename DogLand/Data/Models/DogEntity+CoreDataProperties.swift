//
//  DogEntity+CoreDataProperties.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//
//

import Foundation
import CoreData


extension DogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogEntity> {
        return NSFetchRequest<DogEntity>(entityName: "DogEntity")
    }

    @NSManaged public var age: Int16
    @NSManaged public var dogDescription: String?
    @NSManaged public var dogName: String?
    @NSManaged public var image: String?
    @NSManaged public var dogId: String?

}

extension DogEntity : Identifiable {

}

extension DogEntity {
    func fill(from dog: Dog) {
        self.dogId = dog.id
        self.dogName = dog.name
        self.dogDescription = dog.description
        self.age = Int16(dog.age)
        self.image = dog.image
    }
}
