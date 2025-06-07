//
//  DogRepositoryTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import XCTest

@testable import DogLand

final class DogRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDogsReturnsLocalDataWhenAvailableAndNotForced() async throws {
        let mockAPI = MockAPIClient()
        let mockLocal = MockDogDataSource()
        await mockLocal.saveDogs([
            DogDTO(
                dogName: "Firulais",
                description: "Dog adopted",
                age: 5,
                image: "https://www.test.com"
            )
        ])

        let repo = DogRepositoryImpl(remote: mockAPI, local: mockLocal)
        let dogs = try await repo.getDogs(forceRefresh: false)

        XCTAssertEqual(dogs.count, 1)
        XCTAssertEqual(dogs.first?.name, "Firulais")
    }

    func testGetDogsDownloadsAndSavesWhenLocalIsEmpty() async throws {
        let mockAPI = MockAPIClient()
        mockAPI.response = [
            DogDTO(
                dogName: "Firulais",
                description: "Dog adopted",
                age: 5,
                image: "https://www.test.com"
            )
        ]

        let mockLocal = MockDogDataSource()
        await mockLocal.saveDogs([])

        let repo = DogRepositoryImpl(remote: mockAPI, local: mockLocal)
        let dogs = try await repo.getDogs()

        XCTAssertEqual(dogs.count, 1)
        XCTAssertEqual(dogs.first?.name, "Firulais")
    }

    func test_getDogs_downloadsAndOverwrites_whenForceRefreshIsTrue()
        async throws
    {
        let mockAPI = MockAPIClient()
        mockAPI.response = [
            DogDTO(
                dogName: "Firulais",
                description: "Dog adopted",
                age: 5,
                image: "https://www.test.com"
            )
        ]

        let mockLocal = MockDogDataSource()
        await mockLocal.saveDogs([
            DogDTO(
                dogName: "Firulais",
                description: "Dog adopted",
                age: 5,
                image: "https://www.test.com"
            )
        ])

        let repo = DogRepositoryImpl(remote: mockAPI, local: mockLocal)
        let dogs = try await repo.getDogs(forceRefresh: true)

        XCTAssertEqual(dogs.count, 1)
        XCTAssertEqual(dogs.first?.name, "Firulais")
    }

    func test_getDogs_throwsWhenApiFails() async {
        let mockAPI = MockAPIClient()
        mockAPI.error = URLError(.notConnectedToInternet)

        let mockLocal = MockDogDataSource()

        let repo = DogRepositoryImpl(remote: mockAPI, local: mockLocal)

        do {
            _ = try await repo.getDogs(forceRefresh: true)
            XCTFail("Expected to throw error")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }

}
