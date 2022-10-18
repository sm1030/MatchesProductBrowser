//
//  LocalDataProviderTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class LocalDataProviderTests: XCTestCase {
    
    var localDataProvider: LocalDataProvider!

    override func setUpWithError() throws {
        localDataProvider = LocalDataProvider()
    }

    func testSuccessResult() throws {
        var responseData: Data?
        var responseError: Error?
        
        let url = URL(string: "https://test.test/womens/shop?format=json")!
        let urlRequest = URLRequest(url: url)
        localDataProvider.getData(urlRequest: urlRequest) { data, urlResponse, error in
            responseData = data
            responseError = error
        }

        XCTAssertNil(responseError)
        
        let data = try XCTUnwrap(responseData)
        let dataString = String(decoding: data, as: UTF8.self)
        XCTAssertEqual(dataString.count, 4410890)
    }
    
    func testResourceMissingResult() throws {
        var responseData: Data?
        var responseError: Error?
        
        let url = URL(string: "https://test.test/missing/resource/path")!
        let urlRequest = URLRequest(url: url)
        localDataProvider.getData(urlRequest: urlRequest) { data, urlResponse, error in
            responseData = data
            responseError = error
        }

        XCTAssertNil(responseData)
        
        let error = try XCTUnwrap(responseError)
        XCTAssertEqual(error as? LocalDataProviderError, LocalDataProviderError.bundleResourceNotFoundAtPath(path: "%2Fmissing%2Fresource%2Fpath.json"))
    }
}
