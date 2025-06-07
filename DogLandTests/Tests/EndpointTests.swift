//
//  EndpointTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//

import XCTest
@testable import DogLand

final class EndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDogsEndpointPathAndMethod() {
        let endpoint = Endpoint.dogs
        XCTAssertEqual(endpoint.path, "/1151549092634943488")
        XCTAssertEqual(endpoint.method, .get)
    }

}
