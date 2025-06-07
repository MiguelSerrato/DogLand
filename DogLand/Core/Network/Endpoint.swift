//
//  Endpoint.swift
//  DogLand
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol EndpointRepresentable {
    var path: String { get }
    var method: HTTPMethod { get }
}

enum Endpoint: EndpointRepresentable {
    case dogs
    
    var path: String {
        switch self {
        case .dogs:
            return "/1151549092634943488"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
