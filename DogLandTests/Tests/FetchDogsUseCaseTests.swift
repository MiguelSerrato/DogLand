//
//  FetchDogsUseCaseTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import XCTest

@testable import DogLand

final class FetchDogsUseCaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExecuteReturnsDogsWhenRepositorySucceeds() async throws {
        let mockRepo = MockDogRepository()
        mockRepo.dogsToReturn = [
            Dog(
                name: "Firulais",
                age: 4,
                description: "Homeless dog",
                image: "https://www.test.com"
            ),
            Dog(
                name: "Rocky",
                age: 2,
                description: "Bulldog",
                image: "https://www.test.com"
            ),
        ]
        let useCase = DefaultFetchDogsUseCase(repository: mockRepo)
        let result = try await useCase.execute(forceRefresh: false)

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Firulais")
        XCTAssertEqual(mockRepo.lastForceRefresh, false)
    }

    func testExecuteThrowsErrorWhenRepositoryFails() async {
        let mockRepo = MockDogRepository()
        mockRepo.shouldThrow = true

        let useCase = DefaultFetchDogsUseCase(repository: mockRepo)

        do {
            _ = try await useCase.execute(forceRefresh: true)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
            XCTAssertEqual(mockRepo.lastForceRefresh, true)
        }
    }

}
