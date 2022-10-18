//
//  CurrencyServiceTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class CurrencyServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Register LocalDataProvider with DependencyInjector
        DependencyInjector.shared.register(LocalDataProvider() as DataProviding)
    }

    func testGetCoversionRate() throws {
        
        // Create CurrencyService instant based on CurrencyConverting protocol
        let currencyService: CurrencyConverting = CurrencyService(apikey: "123")
        
        // By default currency set to GBP. We should get same result as input
        XCTAssertEqual(currencyService.convertFromGBP(ammount: 10), 10)
        
        // Let's select currency
        // Let's get conversion rate for GBP/EUR
        var getCoversionRateResult: Result<Bool, Error>?
        currencyService.selectCurrency(currency: .EUR) { result in
            getCoversionRateResult = result
        }

        // The LocalDataProvider is synchronous so we do not have to wait for closure above to complete
        
        // Let's check results
        let unwrappedResult = try XCTUnwrap(getCoversionRateResult)
        switch unwrappedResult {
        case .success(let bool):
            XCTAssertTrue(bool)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
        
        // Now conversion should work as expected
        XCTAssertEqual(currencyService.convertFromGBP(ammount: 10), 11.48)
    }
    
    func testTwoCurrenciesPriceString() throws {
        // Create CurrencyService instant based on CurrencyConverting protocol
        let currencyService: CurrencyConverting = CurrencyService(apikey: "123")

        // Before we selected another currency we should get string with just GBP price
        let singleCurrencyPriceString = currencyService.twoCurrenciesPriceString(price: 12345)
        XCTAssertEqual(singleCurrencyPriceString, "£12 345")

        // Let's select EUR currency
        currencyService.selectCurrency(currency: .EUR) { _ in }

        // Let's get price with two currencies
        let twoCurrenciesPriceString = currencyService.twoCurrenciesPriceString(price: 12345)
        XCTAssertEqual(twoCurrenciesPriceString, "£12 345 (14 183.57 EUR)")

    }
}
