//
//  ProductsRequest.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

class ProductsRequest: APIRequest {
    
    override var urlRequest: URLRequest {
        let url = URL(string: "https://www.matchesfashion.com/womens/shop?format=json")!
        return URLRequest(url: url)
    }
}
