//
//  LocalizableStrings.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import Foundation
import UIKit

enum LocalizableStrings: String {
    case viewPackage
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
