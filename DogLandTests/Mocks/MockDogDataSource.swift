//
//  MockDogDataSource.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation
@testable import DogLand

class MockDogDataSource: CoreDataDogDataSource {
    private var dogs: [Dog] = []
    
    func saveDogs(_ dogs: [Dog]) async {
        self.dogs = dogs
    }
    
    func fetchDogs() async -> [Dog] {
        return dogs
    }
    
    func deleteAllDogs() async {
        dogs = []
    }
}
