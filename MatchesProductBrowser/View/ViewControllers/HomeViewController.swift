//
//  HomeViewController.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func productSelected(product: Product)
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    var homeView: HomeView!
    
    let viewModel: HomeViewModel
    
    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.pageTitle
        
        homeView = HomeView()
        homeView.dockInside(view)
        homeView.tableView.dataSource = viewModel
        
        viewModel.delegate = self
        viewModel.publishCurrencyUpdate()
        viewModel.getProducts()
    }
    
    @objc func onCurrencyButtonAction() {
        let ac = UIAlertController(title: "Please select currency …", message: nil, preferredStyle: .actionSheet)
        for currency in viewModel.getAllCurrencies() {
            ac.addAction(UIAlertAction(title: currency.rawValue, style: .default, handler: selectCurrency))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func selectCurrency(action: UIAlertAction) {
        if let title = action.title, let currency = Currency(rawValue: title) {
            viewModel.selectCurrency(currency: currency)
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func updateCurrencyButton(with currencyText: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: currencyText, style: .plain, target: self, action: #selector(onCurrencyButtonAction))
    }
    
    func productsUpdated() {
        homeView.tableView.reloadData()
    }
    
    func changeActivityIndicatorState(isShowing: Bool) {
        if isShowing {
            homeView.showSpinner()
        } else {
            homeView.hideSpinner()
        }
    }
    
    func onProductCellTap(product: Product) {
        delegate?.productSelected(product: product)
    }
}
