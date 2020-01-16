//
//  SelectCurrencyCoordinator.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class SelectCurrencyCoordinatorImpl: SelectCurrencyCoordinator {
    private let rootController: UINavigationController = {
        let rootController = UINavigationController()
        rootController.setNavigationBarHidden(true, animated: false)
        return rootController
    }()
    private let currencyService: CurrencyService
    private let currencyPairsRepository: CurrencyPairsRepository
    var onFinishFlow: ((Currency, Currency) -> Void)?
    
    init(currencyService: CurrencyService, currencyPairsRepository: CurrencyPairsRepository) {
        self.currencyService = currencyService
        self.currencyPairsRepository = currencyPairsRepository
    }
    
    func start(on viewController: UIViewController) {
        let selectCurrencyViewController = SelectCurrencyViewController.instantiate()
        selectCurrencyViewController.viewModel = SelectCurrencyViewModelImpl(
            currencyService: currencyService,
            currencyPairsRepository: currencyPairsRepository
        )
        selectCurrencyViewController.onSelectCurrency = { [weak self] in
            self?.navigateToSelectSecondCurrencyScreen(selectedCurrency: $0)
        }
        rootController.pushViewController(selectCurrencyViewController, animated: false)
        viewController.present(rootController, animated: true)
    }
}

// MARK: - Private
private extension SelectCurrencyCoordinatorImpl {
    func navigateToSelectSecondCurrencyScreen(selectedCurrency: Currency) {
        let selectCurrencyViewController = SelectCurrencyViewController.instantiate()
        selectCurrencyViewController.viewModel = SelectCurrencyViewModelImpl(
            selectedCurrency: selectedCurrency,
            currencyService: currencyService,
            currencyPairsRepository: currencyPairsRepository
        )
        selectCurrencyViewController.onSelectCurrency = { [weak self] in
            self?.onFinishFlow?(selectedCurrency, $0)
        }
        rootController.pushViewController(selectCurrencyViewController, animated: true)
    }
}
