//
//  CoreDataDogDataSource.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

protocol CoreDataDogDataSource {
    func saveDogs(_ dogs: [Dog]) async throws
    func fetchDogs() async -> [Dog]
    func deleteAllDogs() async
}
