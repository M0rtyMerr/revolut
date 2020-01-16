//
//  AppDelegate.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import UIKit
import Then
import Moya
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // swiftlint:disable:next discouraged_optional_collection
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        window = createWindow()

        let currencyController = CurrencyTableViewController().then {
            let rateService = RateService(rateProvider: MoyaProvider<RateAPI>())
            let rateInteractor = RateInteractorImpl(rateService: rateService, scheduler: SerialDispatchQueueScheduler(qos: .default))
            $0.reactor = CurrencyReactor(rateInteractor: rateInteractor)
        }

        window?.rootViewController = UINavigationController(rootViewController: currencyController)
        return true
    }
}

// MARK: - Private
private extension AppDelegate {
    func createWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds).then {
            $0.backgroundColor = UIColor.white
            $0.makeKeyAndVisible()
        }
    }
}
