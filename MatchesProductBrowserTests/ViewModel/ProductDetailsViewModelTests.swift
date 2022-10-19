//
//  ProductDetailsViewModelTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 19/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class ProductDetailsViewModelTests: XCTestCase {
    
    let mockProduct = Product(code: "12345",
                              name: "Product name",
                              designer: Product.Designer(name: "Designer name"),
                              price: Product.Price(value: 123.45),
                              url: "url",
                              primaryImageMap: Product.PrimaryImageMap(thumbnail: Product.PrimaryImageMap.ImageMap(url: "thumbnail_url"),
                                                                       medium: Product.PrimaryImageMap.ImageMap(url: "medium_url"),
                                                                       large: Product.PrimaryImageMap.ImageMap(url: "large_url")))
    
    override func setUpWithError() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        DependencyInjector.shared.register(CurrencyService(apikey: "") as CurrencyConverting)
    }
    
    func testInit() throws {
        let viewModel = ProductDetailsViewModel(product: mockProduct)
        XCTAssertEqual(viewModel.imageURL, "https:large_url")
        XCTAssertEqual(viewModel.productName, "Product name")
        XCTAssertEqual(viewModel.priceString, "£123.45")
        XCTAssertEqual(viewModel.url, "url")
    }
}
