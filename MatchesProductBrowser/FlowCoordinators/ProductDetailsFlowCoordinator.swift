//
//  ProductDetailsFlowCoordinator.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 18/10/2022.
//

import Foundation

import UIKit

class ProductDetailsFlowCoordinator: FlowCoordinator {
    
    init(product: Product) {
        super.init()
        let viewModel = ProductDetailsViewModel(product: product)
        viewController = ProductDetailsViewController(viewModel: viewModel)
    }
}

//extension HomeFlowCoordinator: ProductDetailsFlowCoordinatorDelegate {
//
//}
