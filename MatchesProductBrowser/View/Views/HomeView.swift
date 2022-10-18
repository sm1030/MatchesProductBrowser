//
//  HomeView.swift
//  MatchesProductBrowser
//
//  Created by Alexandre Malkov on 16/10/2022.
//

import UIKit

class HomeView: UIView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    var spinnerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        addSubview(spinnerBackground)
        addSubview(spinner)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        spinnerBackground.translatesAutoresizingMaskIntoConstraints = false
        spinnerBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spinnerBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spinnerBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        spinnerBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func dockInside(_ view: UIView ) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func showSpinner() {
        spinnerBackground.isHidden = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinnerBackground.isHidden = true
        spinner.stopAnimating()
    }
}
