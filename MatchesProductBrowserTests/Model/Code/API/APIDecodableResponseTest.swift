//
//  APIDecodableResponseTest.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class APIDecodableResponseTest: XCTestCase {
    
    enum TestError: Error, Equatable {
        case myError
    }
    
    func testDecodeSuccessWithValidData() throws {
        // Prepare input data
        let testModel = TestModel(theAnswer: 42)
        let encoder = JSONEncoder()
        let encodedTestModel = try encoder.encode(testModel)
        let urlResponse = HTTPURLResponse(url: URL(string: "http://test.test/path")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        
        // Test decode function
        let apiDecodableResponse = APIDecodableResponse<TestModel>()
        let decodedResponse = apiDecodableResponse.handle(data: encodedTestModel, urlResponse: urlResponse, error: nil)
        switch decodedResponse {
        case .success(let decodedModel):
            XCTAssertEqual(decodedModel.theAnswer, 42)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDecodeSuccessWithBadData() throws {
        let urlResponse = HTTPURLResponse(url: URL(string: "http://test.test/path")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        
        // Test decode function
        let apiDecodableResponse = APIDecodableResponse<TestModel>()
        let decodedResponse = apiDecodableResponse.handle(data: Data(), urlResponse: urlResponse, error: nil)
        switch decodedResponse {
        case .success(_):
            XCTFail("There are should be the failure result")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    
    func testDecodeFailure() throws {
        
        // Test decode function
        let apiDecodableResponse = APIDecodableResponse<TestModel>()
        let decodedResponse = apiDecodableResponse.handle(data: nil, urlResponse: nil, error: TestError.myError)
        switch decodedResponse {
        case .success(_):
            XCTFail("There are should be the failure result")
        case .failure(let error):
            XCTAssertEqual(String(describing: error), "myError")
        }
    }
    
    struct TestModel: Codable {
        let theAnswer: Int
    }
}
