//
//  DogRepository.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

protocol DogRepository {
    func getDogs(forceRefresh: Bool) async throws -> [Dog]
}
