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
        
        let view = UIView()
        view.backgroundColor = .purple
        
        stackView.addArrangedSubview(packageView)
        stackView.addArrangedSubview(view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let package = viewModel.loadPackage()?.first {
            packageView.configure(package)
        }
    }
}

class MainViewModel {
    init() {
        
    }
    
    func loadPackage() -> Package? {
        guard let url = Bundle.main.url(forResource: "packages", withExtension: "json") else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let package = try decoder.decode(Package.self, from: data)
            print(package)
            return package
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
