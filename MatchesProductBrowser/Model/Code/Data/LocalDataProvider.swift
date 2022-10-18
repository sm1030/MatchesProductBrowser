//
//  LocalDataProvider.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

enum LocalDataProviderError: Error, Equatable {
    case bundleResourceNotFoundAtPath(path: String)
    case boundleResourceCouldNotBeRead
    case urlIsNill
}
 
extension LocalDataProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .bundleResourceNotFoundAtPath(let path):
            return "Bundle resource not found at path: \(path)"
        case .boundleResourceCouldNotBeRead:
            return "Bundle resource could not be read"
        case .urlIsNill:
            return "URLRequest url is nill"
        }
    }
}

class LocalDataProvider: DataProviding {
    func getData(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        guard let url = urlRequest.url else {
            completion(nil, nil, LocalDataProviderError.urlIsNill)
            return
        }
        
        var resourcePathString = url.path
        if let query = url.query {
            resourcePathString = "\(resourcePathString)/\(query)"
        }
        resourcePathString = resourcePathString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        guard let resourcePath = Bundle.main.path(forResource: resourcePathString, ofType: "json") else {
            completion(nil, nil, LocalDataProviderError.bundleResourceNotFoundAtPath(path: resourcePathString + ".json"))
            return
        }
        
        // Reading resource
        guard let data = FileManager.default.contents(atPath: resourcePath) else {
            completion(nil, nil, LocalDataProviderError.boundleResourceCouldNotBeRead)
            return
        }
        
        let urlResponse200 = HTTPURLResponse(url: URL(string: "http://test.test")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        
        completion(data, urlResponse200, nil)
    }
}
