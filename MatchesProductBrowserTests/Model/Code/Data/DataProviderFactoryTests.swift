//
//  DataProviderFactoryTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class DataFactoryTests: XCTestCase {
    
    func testUseLocalMockDataProcessInfoArgument() throws {
        XCTAssertEqual(ProcessInfoArgument.useLocalMockData, "-useLocalMockData")
    }

    func testDefaultRemoteDataProvider() throws {
        let dataProvider = DataProviderFactory.dataProvider()
        XCTAssertEqual(String(describing: type(of: dataProvider)), String(describing: RemoteDataProvider.self))
    }
    
    func testLocalDataProviderstUseMockDataProviderWhenProvidedWithClassInit() throws {
        let dataProvider = DataProviderFactory.dataProvider(for: [ProcessInfoArgument.useLocalMockData])
        XCTAssertEqual(String(describing: type(of: dataProvider)), String(describing: LocalDataProvider.self))
    }
}
