//
//  CoreDataDogDataSourceTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import XCTest

@testable import DogLand

final class CoreDataDogDataSourceTests: XCTestCase {

    var dataSource: CoreDataDogDataSource!

    override func setUp() {
        super.setUp()
        dataSource = MockDogDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testSaveAndFetchUsers() async throws {
        let dogsToSave = [
            Dog(
                name: "Firulais",
                age: 4,
                description: "Homeless dog",
                image: "https://www.test.com"
            )
        ]

        try await dataSource.saveDogs(dogsToSave)
        let dogs = await dataSource.fetchDogs()

        XCTAssertEqual(dogs.count, 1)
        XCTAssertEqual(dogs.first?.name, "Firulais")
    }

    func testFetchDogsWhenEmpty() async {
        let dogs = await dataSource.fetchDogs()
        XCTAssertTrue(dogs.isEmpty)
    }

    func testOverwriteDogs() async throws {
        let dogOriginal = [
            Dog(
                name: "Firulais",
                age: 4,
                description: "Homeless dog",
                image: "https://www.test.com"
            )
        ]
        try await dataSource.saveDogs(dogOriginal)

        let dogUpdated = [
            Dog(
                name: "Firulais",
                age: 4,
                description: "Homeless dog",
                image: "https://www.test.com"
            )
        ]
       try await dataSource.saveDogs(dogUpdated)

        let dogs = await dataSource.fetchDogs()
        XCTAssertEqual(dogs.count, 1)
    }

}
