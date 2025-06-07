//
//  APIClient.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

final class APIClient {
    private let session: URLSessionProtocol
    private let baseURL: URL

    init(
        session: URLSessionProtocol = URLSession.shared,
        baseURL: URL = URL(string: "https://jsonblob.com/api")!
    ) {
        self.session = session
        self.baseURL = baseURL
    }

    func request<T: Codable>(endpoint: EndpointRepresentable) async throws -> T
    {
        let fullURL = baseURL.appendingPathComponent(endpoint.path)
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = endpoint.method.rawValue

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
