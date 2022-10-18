//
//  ProductDetailsViewModel.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 18/10/2022.
//

import Foundation

class ProductDetailsViewModel {
    
    let currencyService: CurrencyConverting = DependencyInjector.shared.extract()
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var imageURL: String {
        "https:\(product.primaryImageMap.large.url)"
    }
    
    var productName: String {
        product.name
    }
    
    var priceString: String {
        currencyService.twoCurrenciesPriceString(price: product.price.value)
    }
    
    var url: String {
        product.url
    }
}
