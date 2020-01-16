//
//  AppDelegate.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: PairsCoodinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        coordinator = PairsCoordinatorImpl(
            window: window,
            currencyService: CurrencyServiceImpl(jsonDecoder: JSONDecoder()),
            currencyPairsRepository: CurrencyPairsRepositoryImpl(key: "prod")
        )
        coordinator?.start()
        return true
    }
}

