//
//  MainViewModel.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import Foundation

protocol IMainDataService {
    func loadPackage() async -> Package?
}

class MainDataService: IMainDataService {
    func loadPackage() async -> Package? {
        guard let url = Bundle.main.url(forResource: "packages", withExtension: "json") else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let package = try decoder.decode(Package.self, from: data)
            print(package)
            return package
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}

class MainViewModel {
    let service: IMainDataService = MainDataService()
    private(set) var package: [FormattedPackageElement]?
    
    init() {
        Task {
            package = (await service.loadPackage())?.map {
                FormattedPackageElement(package: $0)
            }
        }
    }
}
