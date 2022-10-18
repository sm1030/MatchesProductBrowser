//
//  ApiRequestTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

enum ApiRequestTestsError: Error, Equatable {
    case testError
}

class ApiRequestTests: XCTestCase {

    func testDataProviderAssignedByDependencyManager() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        let apiRequest = APIRequest()
        XCTAssertEqual(String(describing: type(of: apiRequest.dataProvider)), String(describing: MockDataProvider.self))
    }
    
    func testGetDataPassAllArgumetsAndCallCompletion() throws {
        let mockDataProvider = MockDataProvider()
        mockDataProvider.completionData = Data("ABC".utf8)
        mockDataProvider.completionURLResponse = HTTPURLResponse(url: URL(string: "http://test.test/path")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        mockDataProvider.completionError = ApiRequestTestsError.testError
        DependencyInjector.shared.register(mockDataProvider as DataProviding)
        
        var resultData: Data?
        var resultError: Error?
        var resultURLResponse: URLResponse?
        let apiRequest = TestRequest()
        apiRequest.perform { data, urlResponse, error in
            resultData = data
            resultError = error
            resultURLResponse = urlResponse
        }
        
        // MockDataProvider is not assync, so we can continue test without waiting for result
        let unwrappedResultData = try XCTUnwrap(resultData)
        let unwrappedResultError = try XCTUnwrap(resultError)
        let unwrappedresultURLResponse = try XCTUnwrap(resultURLResponse)
        XCTAssertEqual(String(decoding: unwrappedResultData, as: UTF8.self), "ABC")
        XCTAssertEqual(String(describing: unwrappedResultError), "testError")
        XCTAssertEqual(unwrappedresultURLResponse.url?.absoluteString, "http://test.test/path")
    }
    
    class TestRequest: APIRequest {
        override var urlRequest: URLRequest {
            let url = URL(string: "https://test.test/pass")!
            return URLRequest(url: url)
        }
    }
}

class MockDataProvider: DataProviding {
    
    var urlRequest: URLRequest?

    var completionData: Data?
    var completionURLResponse: HTTPURLResponse?
    var completionError: Error?

    func getData(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.urlRequest = urlRequest
        completion(completionData, completionURLResponse, completionError)
    }
}
