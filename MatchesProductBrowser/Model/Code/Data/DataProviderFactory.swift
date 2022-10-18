//
//  DataProviderFactory.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

struct ProcessInfoArgument {
    static let useLocalMockData = "-useLocalMockData"
}

struct DataProviderFactory {
    
    static func dataProvider(for processInfoArguments: [String] = ProcessInfo.processInfo.arguments) -> DataProviding {
        
        // For UITesting we will use local mock data provided by the LocalDataProvider
        // This will be controlled by the "-useLocalMockData" app launch argument.
        if processInfoArguments.contains(ProcessInfoArgument.useLocalMockData) {
            return LocalDataProvider()
        } else {
            // Otherwise, by default, app should use real remote data provided by the RemoteDataProvider
            return RemoteDataProvider()
        }
    }
}
