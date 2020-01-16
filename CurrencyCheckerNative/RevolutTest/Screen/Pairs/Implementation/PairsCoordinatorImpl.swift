//
//  PairsCoordinatorImpl.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class PairsCoordinatorImpl: PairsCoodinator {
    private let window: UIWindow
    private var selectCurrencyCoordinator: SelectCurrencyCoordinator?
    private let currencyService: CurrencyService
    private let currencyPairsRepository: CurrencyPairsRepository
    
    init(window: UIWindow, currencyService: CurrencyService, currencyPairsRepository: CurrencyPairsRepository) {
        self.window = window
        self.currencyService = currencyService
        self.currencyPairsRepository = currencyPairsRepository
    }
    
    func start() {
        let pairsViewController = PairsViewController.instantiate()
        pairsViewController.title = "Rates & converter"
        pairsViewController.pairsViewModel = PairsViewModelImpl(
            currencyService: currencyService,
            currencyPairsRepository: currencyPairsRepository,
            timer: DispatchSource.makeTimerSource(queue: .global(qos: .userInitiated))
        )
        pairsViewController.onAddPair = { [weak self] in
            self?.navigateToSelectCurrencyCoordinator()
        }
        let navigationController = UINavigationController(rootViewController: pairsViewController)
        window.rootViewController = navigationController
    }
}

// MARK: - Private
private extension PairsCoordinatorImpl {
    func navigateToSelectCurrencyCoordinator() {
        guard let rootViewController = window.rootViewController as? UINavigationController,
            let pairViewController = rootViewController.viewControllers.first as? PairsViewController else { return }
        selectCurrencyCoordinator = SelectCurrencyCoordinatorImpl(currencyService: currencyService, currencyPairsRepository: currencyPairsRepository)
        selectCurrencyCoordinator?.onFinishFlow = { [weak self] sourceCurrency, targetCurrency in
            let newCurrencyPair = CurrencyPair(sourceCurrency: sourceCurrency, targetCurrency: targetCurrency)
            pairViewController.presentedViewController?.dismiss(animated: true) {
                pairViewController.pairsViewModel.add(currencyPair: newCurrencyPair)
            }
            self?.selectCurrencyCoordinator = nil
        }
        selectCurrencyCoordinator?.start(on: rootViewController)
    }
}
