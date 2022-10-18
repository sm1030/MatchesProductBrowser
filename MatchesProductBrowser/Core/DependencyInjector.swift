//
//  DependencyInjector.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import Foundation

// This is very basic Dependency Injection solution that just forward instances of the objects and does not pass around object constructors to instantiate new instances of those objects, but this is eough for this project
public class DependencyInjector {
    
    // We have to use this initializer to make this public class accessable from outside
    public init() {}
    
    /// Singleton instance of the DependencyManager
    public static let shared = DependencyInjector()
    
    /// Dictionary with dependency instances organised by keys
    ///  By default key represent the type name, but you can change it to anything you want to store multiple instances of the same type
    var dependencies: [String: Any] = [:]
    
    /// Store dependencies to the DependencyManager
    /// - Parameters:
    ///   - dependency: Any object instance to be stored here
    ///   - key: By default key represent the type name, but you can change it to anything you want to store multiple instances of the same type
    public func register<T>(_ dependency: T, key: String = String(describing: T.self)) {
        dependencies[key] = dependency
    }
    
    /// Extract dependency from the DependencyManager
    /// - Parameter key: If you leave it empty then it will try to find dependency of the same Generic type, but you can be more specific with the key
    /// - Returns: dependency object
    public func extract<T>(key: String = String(describing: T.self)) -> T {
        if let dependency = dependencies[key] {
            return dependency as! T
        }
        
        fatalError("Dependency not found for key \(T.self)")
    }
}
