//
//  MockDogSataSource.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation
@testable import DogLand

class MockDogDataSource: CoreDataDogDataSource {
    private var dogs: [DogDTO] = []
    
    func saveDogs(_ dogs: [DogDTO]) async {
        self.dogs = dogs
    }
    
    func fetchDogs() async -> [Dog] {
        return dogs.compactMap { dog in
            Dog(
                name: dog.dogName ?? "",
                age: Int(dog.age ?? 0),
                description: dog.description ?? "",
                image: dog.image ?? ""
            )
        }
    }
    
    func deleteAllDogs() async {
        dogs = []
    }
}
