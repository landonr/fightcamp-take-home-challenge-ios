//
//  File.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {
    static func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1000))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1000))
        item.contentInsets = .init(top: 0, leading: .packageSpacing, bottom: 0, trailing: .packageSpacing)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = .packageSpacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension Array where Element == String {
    func combine(
        addNewLine: Bool = false
    ) -> String {
        return reduce("") { partialResult, newText in
            let capitalizedText = newText.capitalized
            guard !addNewLine else {
                return partialResult + "\n" + capitalizedText
            }
            return partialResult != "" ? partialResult + "\n" + capitalizedText : capitalizedText
        }
    }
}

extension UIStackView {
    func setMargin(_ margin: CGFloat) {
        layoutMargins = .init(top: margin, left: margin, bottom: margin, right: margin)
        isLayoutMarginsRelativeArrangement = true
    }
}

extension UIView {
    func anchorAspectRatio(_ multiplier: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func pin(superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
    }

    func pinToSafeArea(superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
    }
}
