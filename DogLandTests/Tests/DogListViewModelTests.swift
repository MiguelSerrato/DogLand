//
//  DogListViewModelTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import XCTest

@testable import DogLand

@MainActor
final class DogListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadDogsSuccessfulFetchSetsDogs() async {
        let useCase = MockFetchDogsUseCase()
        useCase.result = .success([
            Dog(
                name: "Firulais",
                age: 4,
                description: "Homeless dog",
                image: "https://www.test.com"
            )
        ])
        let viewModel = DogListViewModel(fetchDogsUseCase: useCase)

        await viewModel.loadDogs()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.dogs.count, 1)
        XCTAssertEqual(viewModel.dogs.first?.name, "Firulais")
    }

    func testLoadDogsFailureSetsErrorMessage() async {
        let useCase = MockFetchDogsUseCase()
        useCase.result = .failure(URLError(.notConnectedToInternet))
        let viewModel = DogListViewModel(fetchDogsUseCase: useCase)

        await viewModel.loadDogs()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.dogs.count, 0)
        XCTAssertEqual(
            viewModel.errorMessage,
            URLError(.notConnectedToInternet).localizedDescription
        )
    }

    func testLoadDogsSetsIsLoadingWhileFetching() async {
        let useCase = MockFetchDogsUseCase()
        let viewModel = DogListViewModel(fetchDogsUseCase: useCase)

        let expectation = XCTestExpectation(
            description: "loading state toggled"
        )

        Task {
            XCTAssertFalse(viewModel.isLoading)
            await viewModel.loadDogs()
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)
    }

}
