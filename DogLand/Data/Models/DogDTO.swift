//
//  DogDTO.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//

import Foundation

struct DogDTO: Codable, Equatable {
    let dogName: String?
    let description: String?
    let age: Int?
    let image: String?
}
extension DogDTO {
    func toDomain() -> Dog {
        Dog(
            name: dogName ?? "",
            age: age ?? 0,
            description: description ?? "",
            image: image ?? ""
        )
    }
}
