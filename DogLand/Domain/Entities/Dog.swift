//
//  Dog.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 07/06/25.
//

import Foundation

struct Dog: Identifiable, Equatable {
    var id: String { "\(name)-\(age)-\(image.hashValue)-\(description)" }
    let name: String
    let age: Int
    let description: String
    let image: String
}
