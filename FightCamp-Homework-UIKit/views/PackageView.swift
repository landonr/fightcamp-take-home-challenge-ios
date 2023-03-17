//
//  PackageView.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit
import Foundation
import Combine

class PackageViewModel: ObservableObject {
    @Published var activeIndex = 0
}

class PackageView: UIView, ObservableObject {
    @Published private var viewModel = PackageViewModel()
    private var cancellable: AnyCancellable?

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
        textView.backgroundColor = .clear
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
        for index in 0..<Constants.numberOfThumbnails {
            let thumbnailButton = ThumbnailButton(frame: .zero)
            thumbnailStackView.addArrangedSubview(thumbnailButton)
            
            thumbnailButton.addAction(UIAction(title: "", handler: { [weak self] action in
                Task {
                    self?.viewModel.activeIndex = index
                }
                print("active index \(index)")
            }), for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primaryBackground
        layer.cornerRadius = .packageRadius
        addSubview(stackView)
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
    
    fileprivate func setImage(_ index: Int, _ image: UIImage?) {
        if let button = thumbnailStackView.arrangedSubviews[index] as? ThumbnailButton {
            button.setImage(image: image)
            if index == self.viewModel.activeIndex {
                mainImageView.image = image
                button.bordered = true
            } else {
                button.bordered = false
            }
        }
    }
    
    fileprivate func loadImages(imageURLs: [String]) async {
        for (index, imageURL) in imageURLs.compactMap({ URL(string: $0) }).enumerated() {
            let image = try? await ImageService.getImage(url: imageURL)
            setImage(index, image)
        }
    }
    
    fileprivate func setButtonIndex(_ activeIndex: Int) {
        for (buttonIndex, view) in thumbnailStackView.arrangedSubviews.enumerated() {
            guard let button = view as? ThumbnailButton else {
                break
            }
            
            if buttonIndex == activeIndex {
                button.bordered = true
                mainImageView.image = button.getImage()
            } else {
                button.bordered = false
            }
        }
    }
    
    func configure(_ package: FormattedPackageElement) {
        titleLabel.text = package.title
        descLabel.text = package.desc
        paymentLabel.text = package.payment
        priceLabel.text = package.price
        viewButton.setTitle(package.action, for: .normal)
        includedExcludedTextView.attributedText = package.attributedBodyString
        Task.detached(
            priority: .userInitiated, operation: { [weak self] in
                await self?.loadImages(
                    imageURLs: package.thumbnailUrls.compactMap { $0 }
                )
        })

        cancellable = viewModel.$activeIndex.sink { [weak self] activeIndex in
            self?.setButtonIndex(activeIndex)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
