//
//  PackageView.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageView: UIView {
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
    
    let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .price
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        backgroundColor = .white
        stackView.pin(superView: self)
        [titleLabel, descLabel, includedExcludedTextView, paymentLabel, priceLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    fileprivate func combineStringArray(_ strings: [String]) -> String {
        return strings.reduce("") { partialResult, newText in
            return partialResult + "\n" + newText.capitalized
        }
    }
    
    func configure(_ package: PackageElement) {
        titleLabel.text = package.title.uppercased()
        descLabel.text = package.desc.capitalized
        paymentLabel.text = package.payment
        priceLabel.text = "\(package.price)"
        
        let includedText = combineStringArray(package.included)
        if let excludedStrings = package.excluded {
            let excludedText = combineStringArray(excludedStrings)
            
            let fontAttribute: [NSAttributedString.Key: Any] = [
                .font: UIFont.body
            ]
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.body,
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.disabledLabel
            ]
            let includedAttributedString = NSMutableAttributedString(string: includedText, attributes: fontAttribute)
            let excludedAttributedString = NSAttributedString(string: excludedText, attributes: attributes)
            includedAttributedString.append(excludedAttributedString)
            includedExcludedTextView.attributedText = includedAttributedString
        } else {
            includedExcludedTextView.text = includedText
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
