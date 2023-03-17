//
//  PackageView.swift
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

class PackageView: UIView {
    private enum Constants {
        static let numberOfThumbnails = 4
        static let mainImageAspect: CGFloat = 4/3
        static let buttonHeight: CGFloat = 40
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setMargin(.packageSpacing)
        stackView.axis = .vertical
        stackView.spacing = .packageSpacing
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .brandRed
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        
        return label
    }()
    
    let mainImageView: PackageImageView = {
        let imageView = PackageImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.anchorAspectRatio(Constants.mainImageAspect)
        return imageView
    }()
    
    let includedExcludedTextView: UITextView = {
        let textView = UITextView()
        textView.font = .body
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.textContainerInset = .zero
        textView.contentInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }()
    
    let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .thumbnailSpacing
        return stackView
    }()
    
    let thumbnailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .thumbnailSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .thumbnailSpacing
        return stackView
    }()
    
    let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .price
        label.textAlignment = .center
        
        return label
    }()
    
    let viewButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .button
        button.layer.cornerRadius = .buttonRadius
        button.backgroundColor = .buttonBackground
        button.setTitleColor(.buttonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        return button
    }()
    
    private func setupMainStackView() {
        [
            titleLabel,
            descLabel,
            imageStackView,
            includedExcludedTextView,
            priceStackView,
            viewButton
        ].forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupThumbnailStackView() {
        for _ in 0..<Constants.numberOfThumbnails {
            let thumbnailButton = ThumbnailButton(frame: .zero)
            thumbnailStackView.addArrangedSubview(thumbnailButton)
            
            thumbnailButton.addAction(UIAction(title: "", handler: { [weak mainImageView] action in
                if let button = action.sender as? ThumbnailButton {
                    mainImageView?.image = button.getImage()
                    button.bordered = true
                }
            }), for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = .packageRadius
        addSubview(stackView)
        backgroundColor = .white
        stackView.pin(superView: self)
        
        setupMainStackView()
        setupThumbnailStackView()
        
        [mainImageView, thumbnailStackView].forEach {
            imageStackView.addArrangedSubview($0)
        }
        
        [paymentLabel, priceLabel].forEach {
            priceStackView.addArrangedSubview($0)
        }
    }
    
    fileprivate func loadImages(_ package: PackageElement) async {
        Task {
            let images = package.thumbnailUrls
                .compactMap { URL(string: $0) }
            
            for (index, imageURL) in images.enumerated() {
                let image = try await ImageService.getImage(url: imageURL)
                if let button = thumbnailStackView.arrangedSubviews[index] as? ThumbnailButton {
                    button.setImage(image: image)
                }
            }
        }
    }
    
    private func getAttributes(strikeOut: Bool = false) -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat.lineHeightMultiple
        guard !strikeOut else {
            return [
                .font: UIFont.body,
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.disabledLabel,
                .paragraphStyle: paragraphStyle
            ]
        }
        return [
            .font: UIFont.body,
            .paragraphStyle: paragraphStyle
        ]
    }
    
    private func setAttributedText(_ package: PackageElement) {
        let includedText = package.included.combine()
        if let excludedStrings = package.excluded,
           excludedStrings.count > 0 {
            let excludedText = excludedStrings.combine(addNewLine: true)
            let includedAttributedString = NSMutableAttributedString(
                string: includedText,
                attributes: getAttributes()
            )
            let excludedAttributedString = NSAttributedString(
                string: excludedText,
                attributes: getAttributes(strikeOut: true)
            )
            includedAttributedString.append(excludedAttributedString)
            includedExcludedTextView.attributedText = includedAttributedString
        } else {
            includedExcludedTextView.text = includedText
        }
    }
    
    func configure(_ package: PackageElement) {
        titleLabel.text = package.title.uppercased()
        descLabel.text = package.desc.capitalized
        paymentLabel.text = package.payment.capitalized
        priceLabel.text = "\(package.price)"
        viewButton.setTitle(package.action.capitalized, for: .normal)
        
        setAttributedText(package)
        Task {
            await loadImages(package)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
