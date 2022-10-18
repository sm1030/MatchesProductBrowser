//
//  ProductsRequestTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class ProductsRequestTests: XCTestCase {
    
    func testURLRequest() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        let productsRequest = ProductsRequest()
        let urlRequest = productsRequest.urlRequest
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://www.matchesfashion.com/womens/shop?format=json")
    }
}
