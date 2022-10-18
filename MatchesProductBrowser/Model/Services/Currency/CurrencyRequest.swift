//
//  CurrencyRequest.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import Foundation

class CurrencyRequest: APIRequest {
    
    let apiKey: String
    let fromCurrency: String
    let toCurrency: String
    let amount: Double
    
    init(apiKey: String, fromCurrency: String, toCurrency: String, amount: Double) {
        self.apiKey = apiKey
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amount = amount
    }
    
    override var urlRequest: URLRequest {
        let url = URL(string: "https://api.apilayer.com/exchangerates_data/convert?to=\(toCurrency)&from=\(fromCurrency)&amount=\(amount)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "apikey")
        return urlRequest
    }
}
