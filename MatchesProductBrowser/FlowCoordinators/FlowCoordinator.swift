//
//  FlowCoordinator.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 18/10/2022.
//

import UIKit

// This is "Abstract" class of over simplified version of the FlowCoordinator that:
// - construct ViewController that, is represented by flow coordinator, with all ViewModel dependencies
// - perform navigation to other flow coordinators, depending on business logic
// Usually FlowCoordinators should work closely with FlowResolver that knows better where to go in different situations,
// but this solution is enough for this 2 page project
class FlowCoordinator {
    
    // A ViewController that been represented by specific FlowCoordinator inhereted from this class
    var viewController = UIViewController()
    
    // Chilld flow coordinator that been presented from parent flow coordinator
    var childFlowCoordinator: FlowCoordinator?
}
