//
//  HomeFlowCoordinatorTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 19/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class HomeFlowCoordinatorTests: XCTestCase {
    
    let mockProduct = Product(code: "12345",
                              name: "Product name",
                              designer: Product.Designer(name: "Designer name"),
                              price: Product.Price(value: 123.45),
                              url: "url",
                              primaryImageMap: Product.PrimaryImageMap(thumbnail: Product.PrimaryImageMap.ImageMap(url: "thumbnail_url"),
                                                                       medium: Product.PrimaryImageMap.ImageMap(url: "medium_url"),
                                                                       large: Product.PrimaryImageMap.ImageMap(url: "large_url")))
    
    func testInit() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        let homeFlowCoordinator = HomeFlowCoordinator()
        let homeViewController = try XCTUnwrap(homeFlowCoordinator.viewController as? HomeViewController)
        let homeViewModel = try XCTUnwrap(homeViewController.viewModel)
        XCTAssertEqual(homeViewModel.pageTitle, "Products")
    }
    
    func testProductSelected() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        let homeFlowCoordinator = HomeFlowCoordinator()

        let mockViewController = MockViewController()
        homeFlowCoordinator.viewController = mockViewController
        homeFlowCoordinator.productSelected(product: mockProduct)
        
        _ = try XCTUnwrap(mockViewController.viewControllerBeenPresented as? ProductDetailsViewController)
        _ = try XCTUnwrap(homeFlowCoordinator.childFlowCoordinator as? ProductDetailsFlowCoordinator)
    }
}

class MockViewController: UIViewController {
    var viewControllerBeenPresented: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerBeenPresented = viewControllerToPresent
        if let completion = completion {
            completion()
        }
    }
}

