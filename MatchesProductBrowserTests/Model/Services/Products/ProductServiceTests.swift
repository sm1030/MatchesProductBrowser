//
//  ProductServiceTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class ProductServiceTests: XCTestCase {
    
    func testProductsServiceWithLocalDataProvider() throws {
        DependencyInjector.shared.register(LocalDataProvider() as DataProviding)
        let productsService: ProductsProviding = ProductsService()
        var getProductsResult: Result<[Product], Error>?
        productsService.getProducts() { result in
            getProductsResult = result
        }
        
        // The LocalDataProvider is synchronous so we do not have to wait for closure above to complete
        let unwrappedResult = try XCTUnwrap(getProductsResult)
        switch unwrappedResult {
            
        case .success(let products):
            XCTAssertEqual(products.count, 240)
            let firstProduct = try XCTUnwrap(products.first)
            XCTAssertEqual(firstProduct.code, "1500912")
            XCTAssertEqual(firstProduct.name, "Cropped mohair-blend ribbed-knit jacket")
            XCTAssertEqual(firstProduct.designer.name, "Fendi")
            XCTAssertEqual(firstProduct.price.value, 6100.0)
            XCTAssertEqual(firstProduct.primaryImageMap.thumbnail.url, "//assetsprx.matchesfashion.com/img/product/1500912_1_thumbnail.jpg")
            XCTAssertEqual(firstProduct.primaryImageMap.medium.url, "//assetsprx.matchesfashion.com/img/product/1500912_1_medium.jpg")
            XCTAssertEqual(firstProduct.primaryImageMap.large.url, "//assetsprx.matchesfashion.com/img/product/1500912_1_large.jpg")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testProductsServiceWithEmptyMockDataProvider() throws {
        let mockDataProvider = MockDataProvider()
        mockDataProvider.completionData = Data("ABC".utf8)
        mockDataProvider.completionURLResponse = HTTPURLResponse(url: URL(string: "http://test.test/path")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        DependencyInjector.shared.register(mockDataProvider as DataProviding)
        let productsService: ProductsProviding = ProductsService()
        var getProductsResult: Result<[Product], Error>?
        productsService.getProducts() { result in
            getProductsResult = result
        }
        
        // The LocalDataProvider is synchronous so we do not have to wait for closure above to complete
        let unwrappedResult = try XCTUnwrap(getProductsResult)
        switch unwrappedResult {
        case .success(_):
            XCTFail("There are should be the failure result")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
}
