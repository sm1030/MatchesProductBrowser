//
//  HomeViewModel.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func changeActivityIndicatorState(isShowing: Bool)
    func updateCurrencyButton(with currencyText: String)
    func productsUpdated()
    func onProductCellTap(product: Product)
}

class HomeViewModel: NSObject, UITableViewDataSource {
    
    let errorReportingSercie: ErrorReporting = DependencyInjector.shared.extract()
    let productsSercie: ProductsProviding = DependencyInjector.shared.extract()
    let currencyService: CurrencyConverting = DependencyInjector.shared.extract()
    
    weak var delegate: HomeViewModelDelegate?
    
    var products: [Product] = []
    
    let pageTitle = "Products"
    
    func getAllCurrencies() -> [Currency] {
        return Currency.allCases
    }
    
    func selectCurrency(currency: Currency) {
        delegate?.changeActivityIndicatorState(isShowing: true)
        currencyService.selectCurrency(currency: currency) { [weak self] result in
            self?.delegate?.changeActivityIndicatorState(isShowing: false)
            switch result {
            case .success(_):
                self?.publishCurrencyUpdate()
                self?.delegate?.productsUpdated()
            case .failure(let error):
                self?.errorReportingSercie.reportError(error: error)
            }
        }
    }
    
    func publishCurrencyUpdate() {
        delegate?.updateCurrencyButton(with: currencyService.selectedCurrency.rawValue)
    }
    
    func getProducts() {
        delegate?.changeActivityIndicatorState(isShowing: true)
        productsSercie.getProducts { [weak self] result in
            self?.delegate?.changeActivityIndicatorState(isShowing: false)
            
            switch result {
            case .success(let products):
                self?.products = products
                self?.delegate?.productsUpdated()
            case .failure(let error):
                // In the real app I would notify the user and asking if data should be reloaded again
                // I will just "report" the error
                self?.errorReportingSercie.reportError(error: error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row < products.count {
            let product = products[indexPath.row]
            let priceString = currencyService.twoCurrenciesPriceString(price: product.price.value)
            cell.contentConfiguration = ProductCellContentConfiguration(homeViewModel: self,
                                                                        product: product,
                                                                        productName: product.name,
                                                                        designerName: product.designer.name,
                                                                        priceString: priceString,
                                                                        imageURLString: "https:\(product.primaryImageMap.thumbnail.url)")
        }
        return cell
    }
}

extension HomeViewModel: ProductCellContentDelegate {
    func onTap(product: Product) {
        delegate?.onProductCellTap(product: product)
    }
}
