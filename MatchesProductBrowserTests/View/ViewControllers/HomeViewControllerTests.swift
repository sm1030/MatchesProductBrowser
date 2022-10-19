//
//  HomeViewControllerTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 19/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class HomeViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
        DependencyInjector.shared.register(MockDataProvider() as DataProviding)
        DependencyInjector.shared.register(ProductsService() as ProductsProviding)
        DependencyInjector.shared.register(CurrencyService(apikey: "") as CurrencyConverting)
    }
    
    func testInit() throws {
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        XCTAssertTrue(homeViewController.viewModel === homeViewModel)
    }
    
    func testViewDidLoad() {
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        homeViewController.viewDidLoad()
        
        XCTAssertEqual(homeViewController.navigationItem.title, "Products")
        XCTAssertTrue(homeViewController.homeView.tableView.dataSource === homeViewModel)
        XCTAssertTrue(homeViewController.viewModel.delegate === homeViewController)
    }
    
    func testOnCurrencyButtonAction() throws {
        class MockHomeViewController: HomeViewController {
            var viewControllerToPresent: UIViewController?
            override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
                self.viewControllerToPresent = viewControllerToPresent
            }
        }
        
        let homeViewModel = HomeViewModel()
        let homeViewController = MockHomeViewController(viewModel: homeViewModel)
        homeViewController.onCurrencyButtonAction()
        
        let alertViewController = try XCTUnwrap(homeViewController.viewControllerToPresent as? UIAlertController)
        XCTAssertEqual(alertViewController.title, "Please select currency …")
    }
    
    func testSelectCurrency() {
        class MockHomeViewModel: HomeViewModel {
            var selectedCurrency: Currency?
            override func selectCurrency(currency: Currency) {
                selectedCurrency = currency
            }
        }
        
        let homeViewModel = MockHomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        let alertAction = UIAlertAction(title: "EUR", style: .default)
        homeViewController.selectCurrency(action: alertAction)
        
        XCTAssertEqual(homeViewModel.selectedCurrency?.rawValue, "EUR")
    }
    
    // I could write more HomeViewController tests, but you got the idea ...
    
}

