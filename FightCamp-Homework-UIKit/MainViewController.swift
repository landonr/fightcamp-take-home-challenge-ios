//
//  MainViewController.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    enum PackageSection: Hashable {
        case main
    }

    private let viewModel = MainViewModel()
    private let packageView = PackageView()
    private var collectionViewCancellable: AnyCancellable?
    private var dataSource: UICollectionViewDiffableDataSource<Int, PackageElement>?

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .createBasicListLayout()
        )
        collectionView.register(
            PackageCollectionViewCell.self,
            forCellWithReuseIdentifier: PackageCollectionViewCell.identifier
        )

        return collectionView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .secondaryBackground
        view.addSubview(collectionView)
        collectionView.pinToSafeArea(superView: view)
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PackageCollectionViewCell.identifier,
                for: indexPath
            ) as? PackageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(itemIdentifier)
            return cell
        })
    
        collectionViewCancellable = viewModel.package.publisher.sink { [weak self] package in
            if let package = package.first {
                self?.packageView.configure(package)
                self?.packageView.viewButton.addAction(UIAction(title: "", handler: { _ in
                    print("view \(package.title)")
                }), for: .touchUpInside)
            }
            
            var snapshot = NSDiffableDataSourceSnapshot<Int, PackageElement>()
            snapshot.appendSections([0])
            snapshot.appendItems(package)
            self?.dataSource?.apply(snapshot)
        }
    }
}
