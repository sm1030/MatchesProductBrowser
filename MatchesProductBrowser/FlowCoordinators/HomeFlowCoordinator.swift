//
//  HomeFlowCoordinator.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import UIKit

class HomeFlowCoordinator: FlowCoordinator {
    
    override init() {
        super.init()
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.delegate = self
        viewController = homeViewController
    }
}

extension HomeFlowCoordinator: HomeViewControllerDelegate {
    func productSelected(product: Product) {
        childFlowCoordinator = ProductDetailsFlowCoordinator(product: product)
        viewController.present(childFlowCoordinator!.viewController, animated: true)
    }
}
