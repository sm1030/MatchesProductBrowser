//
//  MatchesProductBrowserUITests.swift
//  MatchesProductBrowserUITests
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import XCTest

class MatchesProductBrowserUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["-useLocalMockData"]
        app.launch()
        
        app.buttons["GBP"].tap()
        app.buttons["EUR"].tap()
        app.tables.staticTexts["£1 890 (2 171.48 EUR)"].tap()
        app.scrollViews.otherElements.buttons["xmark"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
