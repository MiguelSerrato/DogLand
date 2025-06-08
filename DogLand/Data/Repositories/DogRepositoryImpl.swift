//
//  DogRepositoryImpl.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

final class DogRepositoryImpl: DogRepository {
    private let remote: APIClient
    private let local: CoreDataDogDataSource

    init(remote: APIClient, local: CoreDataDogDataSource) {
        self.remote = remote
        self.local = local
    }

    func getDogs(forceRefresh: Bool = false) async throws -> [Dog] {
        if !forceRefresh {
            let localData = await local.fetchDogs()
            if !localData.isEmpty {
                return localData
            }
        }
        let endpoint: EndpointRepresentable = Endpoint.dogs
        let remoteData: [DogDTO] = try await remote.request(endpoint: endpoint)
        await local.saveDogs(remoteData.map { $0.toDomain() })
        return await local.fetchDogs()

    }
}
