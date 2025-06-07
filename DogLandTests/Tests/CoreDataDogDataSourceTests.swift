//
//  CoreDataDogDataSourceTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import CoreData
import XCTest

@testable import DogLand

final class CoreDataDogDataSourceTests: XCTestCase {

    var container: NSPersistentContainer!
    var dataSource: CoreDataDogDataSource!

    override func setUp() {
        super.setUp()
        container = CoreDataStack.inMemoryStack()
        dataSource = CoreDataDogDataSourceImpl(context: container.viewContext)
    }

    override func tearDown() {
        container = nil
        dataSource = nil
        super.tearDown()
    }

    func testSaveAndFetchUsers() async throws {
        let dogsToSave = [
            DogDTO(
                dogName: "Firulais",
                description: "Homeless dog",
                age: 4,
                image: "https://www.test.com"
            )
        ]

        await dataSource.saveDogs(dogsToSave)
        let dogs = await dataSource.fetchDogs()

        XCTAssertEqual(dogs.count, 1)
        XCTAssertEqual(dogs.first?.name, "Firulais")
    }

    func testFetchDogsWhenEmpty() async {
        let dogs = await dataSource.fetchDogs()
        XCTAssertTrue(dogs.isEmpty)
    }

    func testOverwriteDogs() async {
        let dogOriginal = [
            DogDTO(
                dogName: "Firulais",
                description: "Homeless dog",
                age: 4,
                image: "https://www.test.com"
            )
        ]
        await dataSource.saveDogs(dogOriginal)

        let dogUpdated = [
            DogDTO(
                dogName: "Firulais",
                description: "Dog adopted",
                age: 5,
                image: "https://www.test.com"
            )
        ]
        await dataSource.saveDogs(dogUpdated)

        let dogs = await dataSource.fetchDogs()
        XCTAssertEqual(dogs.count, 2)
    }

}
