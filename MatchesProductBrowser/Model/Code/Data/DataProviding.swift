//
//  DataProviding.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

protocol DataProviding {
    func getData(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
