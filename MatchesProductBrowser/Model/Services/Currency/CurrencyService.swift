//
//  CurrencyService.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

protocol CurrencyConverting {
    init(apikey: String)
    var selectedCurrency: Currency { get }
    func selectCurrency(currency: Currency, _ completion: @escaping(Result<Bool, Error>) -> Void)
    func convertFromGBP(ammount: Double) -> Double?
    func twoCurrenciesPriceString(price: Double) -> String
}

enum Currency: String, CaseIterable {
    case GBP
    case EUR
    case USD
    case CHF
    case SEK
}

class CurrencyService: CurrencyConverting {
    
    private let apikey: String
    
    private(set) public var selectedCurrency: Currency
    
    private var exchangeRates: [Currency: Double] = [.GBP: 1.0]
    
    required init(apikey: String) {
        self.apikey = apikey
        selectedCurrency = .GBP
    }
    
    func selectCurrency(currency: Currency, _ completion: @escaping(Result<Bool, Error>) -> Void) {
        if exchangeRates[currency] == nil {
            getCoversionRate(to: currency) { [weak self] result in
                switch result {
                case .success(_):
                    self?.selectedCurrency = currency
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            selectedCurrency = currency
            completion(.success(true))
        }
    }
    
    private func getCoversionRate(to currency: Currency, _ completion: @escaping(Result<Bool, Error>) -> Void) {
        
        let request = CurrencyRequest(apiKey: apikey,
                                      fromCurrency: "GBP",
                                      toCurrency: currency.rawValue,
                                      amount: 1)
        let response = CurrencyResponse()

        request.perform { [weak self] data, urlResponse, error in
            guard let self = self else { return }
            let decodedResult = response.handle(data: data, urlResponse: urlResponse, error: error)
            
            switch decodedResult {
            case .success(let results):
                self.exchangeRates[currency] = results.result
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func convertFromGBP(ammount: Double) -> Double? {
        guard let rate = exchangeRates[selectedCurrency] else {
            return nil
        }
        
        // We multiply and then divide by 100 to round value down to pence
        return Double(Int(rate * ammount * 100)) / 100
    }
    
    func twoCurrenciesPriceString(price: Double) -> String {
        
        // Formater with thousand space separator
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "

        let gbpPriceString = "£\(formatter.string(from: NSNumber(value: price))!)"
        
        if let convertedPrice = convertFromGBP(ammount: price), selectedCurrency != .GBP {
            return "\(gbpPriceString) (\(formatter.string(from: NSNumber(value: convertedPrice))!) \(selectedCurrency.rawValue))"
        } else {
            return gbpPriceString
        }
    }
}
