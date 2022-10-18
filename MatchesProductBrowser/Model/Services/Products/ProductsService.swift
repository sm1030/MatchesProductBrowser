//
//  ProductsService.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

protocol ProductsProviding {
    func getProducts(_ completion: @escaping(Result<[Product], Error>) -> Void)
}

class ProductsService: ProductsProviding {
    
    func getProducts(_ completion: @escaping(Result<[Product], Error>) -> Void) {
        
        let request = ProductsRequest()
        let response = ProductsResponse()
        
        request.perform { data, urlResponse, error in
            let decodedResult = response.handle(data: data, urlResponse: urlResponse, error: error)
            
            switch decodedResult {
            case .success(let results):
                completion(.success(results.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
