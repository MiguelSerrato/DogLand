//
//  MockFetchDogsUseCase.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

@testable import DogLand

final class MockFetchDogsUseCase: FetchDogsUseCase {
    var result: Result<[Dog], Error> = .success([])

    func execute(forceRefresh: Bool) async throws -> [Dog] {
        switch result {
        case .success(let dogs): return dogs
        case .failure(let error): throw error
        }
    }
}
