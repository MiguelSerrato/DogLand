//
//  APIClientTests.swift
//  DogLandTests
//
//  Created by Jose Miguel Serrato Moreno on 06/06/25.
//

import XCTest
@testable import DogLand

final class APIClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIClientFetchesDogsSuccessfully() async throws {
        let mockSession = MockURLSession()
        let expectedDog = DogDTO(dogName: "Firulais", description: "Homeless dog", age: 4, image: "https://www.test.com")
        mockSession.dataToReturn = try! JSONEncoder().encode([expectedDog])
        mockSession.responseToReturn = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                                       statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let client = APIClientImpl(session: mockSession, baseURL: URL(string: "https://test.com")!)
        let result: [DogDTO] = try await client.request(endpoint: Endpoint.dogs)
        
        XCTAssertEqual(result.first, expectedDog)
    }
    
    func testNon200ResponseThrowsError() async {
        let session = MockURLSession()
        session.dataToReturn = Data()
        session.responseToReturn = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        let client = APIClientImpl(session: session, baseURL: URL(string: "https://test.com")!)
        
        do {
            let _: [DogDTO] = try await client.request(endpoint: Endpoint.dogs)
            XCTFail("Expected to throw")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func testInvalidJSONThrowsDecodingError() async {
        let session = MockURLSession()
        session.dataToReturn = Data("invalid json".utf8)
        session.responseToReturn = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let client = APIClientImpl(session: session, baseURL: URL(string: "https://test.com")!)
        
        do {
            let _: [DogDTO] = try await client.request(endpoint: Endpoint.dogs)
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func testNetworkErrorIsThrown() async {
        let session = MockURLSession()
        session.errorToThrow = URLError(.timedOut)
        
        let client = APIClientImpl(session: session, baseURL: URL(string: "https://test.com")!)
        
        do {
            let _: [DogDTO] = try await client.request(endpoint: Endpoint.dogs)
            XCTFail("Expected network error")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .timedOut)
        }
    }
    
    func testRequestMethodAndPathAreCorrect() async throws {
        let expectedDog = DogDTO(dogName: "Firulais", description: "Homeless dog", age: 4, image: "https://www.test.com")
        let session = MockURLSession()
        session.dataToReturn = try JSONEncoder().encode([expectedDog])
        session.responseToReturn = HTTPURLResponse(url: URL(string: "https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let client = APIClientImpl(session: session, baseURL: URL(string: "https://test.com")!)
        let _: [DogDTO] = try await client.request(endpoint: Endpoint.dogs)
        
        XCTAssertEqual(session.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(session.lastRequest?.url?.path, "/1151549092634943488")
    }

}
