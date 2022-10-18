//
//  APIDecodableResponse.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

enum APIDecodableResponseError: Error, Equatable {
    case dataIsNill
}
 
extension APIDecodableResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataIsNill:
            return "Response data is nill"
        }
    }
}

class APIDecodableResponse<T: Decodable> {
    func handle(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<T, Error> {
        
        if let error = error {
            return .failure(error)
        }

        guard let data = data else {
            return .failure(APIDecodableResponseError.dataIsNill)
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(error)
        }
    }
}
