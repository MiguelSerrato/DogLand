//
//  MockAPIClient.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

@testable import DogLand

final class MockAPIClient: APIClient {
    var response: Any?
    var error: Error?

    func request<T: Codable>(endpoint: EndpointRepresentable) async throws -> T
    {
        if let error = error {
            throw error
        }
        guard let typedResponse = response as? T else {
            fatalError("Invalid type cast in mock")
        }
        return typedResponse
    }

}
