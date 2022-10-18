//
//  DependencyInjectorTests.swift
//  MatchesProductBrowserTests
//
//  Created by Alexandre Malkov on 18/10/2022.
//

import XCTest
@testable import MatchesProductBrowser

class DependencyInjectorTests: XCTestCase {

    func testSingletonSharedProperty() {
        let instanceA = DependencyInjector.shared
        let instanceB = DependencyInjector.shared
        XCTAssertTrue(instanceA === instanceB)
    }
    
    override func tearDownWithError() throws {
        DependencyInjector.shared.dependencies.removeAll()
    }
    
    func testTypeDrivenApproach() throws {
        let di = DependencyInjector.shared
        
        // Register data
        di.register(3)
        di.register("Hello World!")
        di.register(Car(make: "Home made", price: 123, topSpeed: 30))
        di.register(di)
        
        // Extract data
        let int: Int = di.extract()
        let string: String = di.extract()
        let car: Car = di.extract()
        let dependencyInjector: DependencyInjector = di.extract()
        
        // Validate
        XCTAssertEqual(int, 3)
        XCTAssertEqual(string, "Hello World!")
        XCTAssertEqual(car, Car(make: "Home made", price: 123, topSpeed: 30))
        XCTAssertTrue(dependencyInjector === di)
    }
    
    func testKeyDrivenApproach() throws {
        let di = DependencyInjector.shared
        
        // Register data
        di.register(5, key: "Five")
        di.register(7, key: "Seven")
        
        // Extract data
        let five: Int = di.extract(key: "Five")
        let seven: Int = di.extract(key: "Seven")
        
        // Validate
        XCTAssertEqual(five, 5)
        XCTAssertEqual(seven, 7)
    }
}

struct Car: Equatable {
    let make: String
    let price: Double
    let topSpeed: Int
}
