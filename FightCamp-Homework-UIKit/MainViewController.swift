//
//  MainViewController.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let packageView = PackageView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.setMargin(.packageSpacing)
        return stackView
    }()
    
    override func viewDidLoad() {
        view.addSubview(stackView)
        view.backgroundColor = .secondaryBackground
        stackView.pinToSafeArea(superView: view)
        
        stackView.addArrangedSubview(packageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = viewModel.package.publisher.sink { [weak packageView] package in
            if let package = package.first {
                packageView?.configure(package)
            }
        }
    }
}
