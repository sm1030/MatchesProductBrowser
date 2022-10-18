//
//  ProductCellContentConfiguration.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import UIKit
import SDWebImage

protocol ProductCellContentDelegate: AnyObject {
    func onTap(product: Product)
}

struct ProductCellContentConfiguration: UIContentConfiguration {
    let homeViewModel: HomeViewModel
    let product: Product
    let productName: String
    let designerName: String
    let priceString: String
    let imageURLString: String
    
    func makeContentView() -> UIView & UIContentView {
        let productCellContentView = ProductCellContentView(configuration: self)
        return productCellContentView
    }
    
    func updated(for state: UIConfigurationState) -> ProductCellContentConfiguration {
        return self
    }
}

class ProductCellContentView: UIView, UIContentView {
    
    weak var delegate: ProductCellContentDelegate?
    
    var product: Product!
    
    var configuration: UIContentConfiguration {
        didSet {
            self.configure()
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    
    var designerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    var priceStringLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)

        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.distribution = .fillProportionally
        vStackView.addArrangedSubview(productNameLabel)
        vStackView.addArrangedSubview(designerNameLabel)
        vStackView.addArrangedSubview(priceStringLabel)
        
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.spacing = 15
        hStackView.addArrangedSubview(imageView)
        hStackView.addArrangedSubview(vStackView)
        imageView.widthAnchor.constraint(equalToConstant: 89.5).isActive = true
        let imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 119.5)
        imageViewHeightConstraint.priority = UILayoutPriority(999)
        imageViewHeightConstraint.isActive = true
        
        
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let config = self.configuration as? ProductCellContentConfiguration else { return }
        delegate = config.homeViewModel
        product = config.product
        productNameLabel.text = config.productName
        designerNameLabel.text = config.designerName
        priceStringLabel.text = config.priceString
        imageView.sd_setImage(with: URL(string: config.imageURLString))
    }

    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.onTap(product: product)
    }
}
