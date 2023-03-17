//
//  PackageCollectionViewCell.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "PackageCollectionViewCell"

    private let view = PackageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.pin(superView: self)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ package: FormattedPackageElement) {
        view.configure(package)
    }
}
