//
//  MockDogRepository.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

@testable import DogLand

final class MockDogRepository: DogRepository {
    var dogsToReturn: [Dog] = []
    var lastForceRefresh: Bool?
    var shouldThrow = false

    func getDogs(forceRefresh: Bool) async throws -> [Dog] {
        lastForceRefresh = forceRefresh

        if shouldThrow {
            throw URLError(.notConnectedToInternet)
        }

        return dogsToReturn
    }
}
