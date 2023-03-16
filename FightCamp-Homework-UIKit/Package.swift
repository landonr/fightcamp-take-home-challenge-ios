//
//  Package.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import Foundation

// MARK: - PackageElement
struct PackageElement: Codable {
    let title, desc: String
    let thumbnailUrls: [String]
    let included: [String]
    let excluded: [String]?
    let payment: String
    let price: Int
    let action: String
    let headline: String?

    enum CodingKeys: String, CodingKey {
        case title, desc
        case thumbnailUrls = "thumbnail_urls"
        case included, excluded, payment, price, action, headline
    }
}

typealias Package = [PackageElement]
