//
//  ProductDetailsViewController.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 15/10/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var productDetailsView: ProductDetailsView!
    
    let viewModel: ProductDetailsViewModel
    
    required init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailsView = ProductDetailsView(viewModel: viewModel)
        productDetailsView.dockInside(view)
        productDetailsView.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    @objc func closeButtonAction(sender: UIButton!) {
        dismiss(animated: true)
     }
}
