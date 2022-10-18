//
//  RemoteDataProviderTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class RemoteDataProviderTests: XCTestCase {
    
    func testBadResponseWirhErrorResponse() throws {
        var responseData: Data?
        var responseError: Error?
        var responseURLResponse: URLResponse?
        
        let url = URL(string: "https://test.test/test")!
        let urlRequest = URLRequest(url: url)
        let remoteDataProvider = RemoteDataProvider()
        let expectation = self.expectation(description: "Quering")
        remoteDataProvider.getData(urlRequest: urlRequest) { data, urlResponse, error in
            responseData = data
            responseError = error
            responseURLResponse = urlResponse
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseData)
        XCTAssertNil(responseURLResponse)
        
        let error = try XCTUnwrap(responseError)
        XCTAssertEqual(error.localizedDescription, "A server with the specified hostname could not be found.")
    }
}
