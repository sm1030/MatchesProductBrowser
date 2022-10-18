//
//  APIRequest.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

class APIRequest {
    
    let dataProvider: DataProviding = DependencyInjector.shared.extract()
    
    var urlRequest: URLRequest {
        fatalError("urlRequest has not been implemented")
    }

    func perform(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        dataProvider.getData(urlRequest: urlRequest) { data, urlResponse, error in
            completion(data, urlResponse, error)
        }
    }
}
