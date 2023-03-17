//
//  PackageImageView.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageImageView: UIImageView {
    fileprivate func sharedInit() {
        layer.cornerRadius = .thumbnailRadius
        backgroundColor = .secondaryBackground
        clipsToBounds = true
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        sharedInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
