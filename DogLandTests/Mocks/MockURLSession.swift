//
//  Untitled.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//
@testable import DogLand
import Foundation

final class MockURLSession: URLSessionProtocol {
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToThrow: Error?
    var lastRequest: URLRequest?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        lastRequest = request
        if let error = errorToThrow { throw error }
        guard let data = dataToReturn, let response = responseToReturn else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
