//
//  SelectCurrencyCoordinator.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

protocol SelectCurrencyCoordinator {
    func start(on viewController: UIViewController)
    var onFinishFlow: ((Currency, Currency) -> Void)? { get set }
}
