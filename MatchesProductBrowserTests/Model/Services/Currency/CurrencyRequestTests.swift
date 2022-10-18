//
//  CurrencyRequestTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class CurrencyRequestTests: XCTestCase {
    
    func testURLRequest() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        let currencyRequest = CurrencyRequest(apiKey: "123", fromCurrency: "GBP", toCurrency: "EUR", amount: 1)
        let urlRequest = currencyRequest.urlRequest
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["apikey": "123"])
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.apilayer.com/exchangerates_data/convert?to=EUR&from=GBP&amount=1.0")
    }
}
