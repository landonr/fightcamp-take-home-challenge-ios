//
//  FormattedPackageElement.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

struct FormattedPackageElement: Hashable {
    private static func getAttributes(strikeOut: Bool = false) -> [NSAttributedString.Key : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat.lineHeightMultiple
        guard !strikeOut else {
            return [
                .font: UIFont.body,
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.disabledLabel,
                .paragraphStyle: paragraphStyle,
            ]
        }
        return [
            .font: UIFont.body,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.label,
        ]
    }
    
    private static func getAttributedText(_ package: PackageElement) -> NSAttributedString {
        let includedText = package.included.combine()
        let includedAttributedString = NSMutableAttributedString(
            string: includedText,
            attributes: getAttributes()
        )
        if let excludedStrings = package.excluded,
           excludedStrings.count > 0 {
            let excludedText = excludedStrings.combine(addNewLine: true)
            
            let excludedAttributedString = NSAttributedString(
                string: excludedText,
                attributes: getAttributes(strikeOut: true)
            )
            includedAttributedString.append(excludedAttributedString)
        }
        return includedAttributedString
    }

    init(package: PackageElement) {
        title = package.title.uppercased()
        desc = package.desc.capitalized
        thumbnailUrls = package.thumbnailUrls
        payment = package.payment.capitalized
        price = "$\(package.price)"
        action = package.action.capitalized
        headline = package.headline
        attributedBodyString = FormattedPackageElement.getAttributedText(package)
    }

    let title, desc, payment, price, action: String
    let thumbnailUrls: [String]
    let attributedBodyString: NSAttributedString
    let headline: String?
}
