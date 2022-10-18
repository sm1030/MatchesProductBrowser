//
//  ErrorReportingService.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 17/10/2022.
//

import Foundation

protocol ErrorReporting: AnyObject {
    func reportError(error: Error)
}

// This class is a placeholder for something more appropriate
class ErrorReportingService: ErrorReporting {
    
    func reportError(error: Error) {
        
        print("ERROR RPORTING: \(error)")
    }
}
