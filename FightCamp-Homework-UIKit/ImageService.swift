//
//  ImageService.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class ImageService {
    static func getImage(url: URL) async throws -> UIImage? {
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
}
