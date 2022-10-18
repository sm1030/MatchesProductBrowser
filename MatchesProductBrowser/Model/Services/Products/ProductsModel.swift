//
//  ProductsModel.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

struct ProductsResponseModel: Decodable {
    let results: [Product]
}

struct Product: Decodable {
    let code: String
    let name: String
    let designer: Designer
    let price: Price
    let url: String
    let primaryImageMap: PrimaryImageMap
    
    struct Designer: Decodable {
        let name: String
    }
    
    struct Price: Decodable {
        let value: Double
    }
    
    struct PrimaryImageMap: Decodable {
        let thumbnail: ImageMap
        let medium: ImageMap
        let large: ImageMap
        
        struct ImageMap: Decodable {
            let url: String
        }
    }
}
