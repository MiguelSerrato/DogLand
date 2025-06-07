//
//  FetchDogsUseCase.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

protocol FetchDogsUseCase {
    func execute(forceRefresh: Bool) async throws -> [Dog]
}

final class DefaultFetchDogsUseCase: FetchDogsUseCase {
    private let repository: DogRepository
    
    init(repository: DogRepository) {
        self.repository = repository
    }
    
    func execute(forceRefresh: Bool) async throws -> [Dog] {
        return try await repository.getDogs(forceRefresh: forceRefresh)
    }
}
