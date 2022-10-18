//
//  RemoteDataProvider.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

class RemoteDataProvider: DataProviding {
    
    func getData(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            }.resume()
        }
    }
}
