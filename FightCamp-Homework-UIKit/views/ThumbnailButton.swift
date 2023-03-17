//
//  ThumbnailButton.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class ThumbnailButton: UIButton {
    private var packageImageView: PackageImageView
    var bordered = false {
            didSet {
            setBorder()
        }
    }

    fileprivate func setBorder() {
        if bordered {
            layer.borderColor = UIColor.brandRed.cgColor
            layer.borderWidth = .thumbnailBorderWidth
        } else {
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0
        }
    }

    override init(frame: CGRect) {
        packageImageView = PackageImageView(frame: frame)
        super.init(frame: frame)
        packageImageView.anchorAspectRatio()
        addSubview(packageImageView)
        packageImageView.pin(superView: self)
        layer.cornerRadius = .thumbnailRadius
        clipsToBounds = true
        setBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage?) {
        packageImageView.image = image
    }
    
    func getImage() -> UIImage? {
        return packageImageView.image
    }
}
