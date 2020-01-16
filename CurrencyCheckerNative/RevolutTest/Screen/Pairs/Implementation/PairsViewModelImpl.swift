//
//  PairsViewModelImpl.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

final class PairsViewModelImpl: PairsViewModel {
    var onChange: (([CurrencyPair]) -> Void)?
    private let timer: DispatchSourceTimer
    private let currencyService: CurrencyService
    private let currencyPairsRepository: CurrencyPairsRepository
    private var currentTask: URLSessionTask?
    
    init(currencyService: CurrencyService, currencyPairsRepository: CurrencyPairsRepository, timer: DispatchSourceTimer) {
        self.currencyService = currencyService
        self.currencyPairsRepository = currencyPairsRepository
        self.timer = timer
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler { [weak self] in
            self?.pollCurrencyPairs()
        }
    }
    
    func viewWillAppear() {
        timer.resume()
    }
    
    func viewWillDisappear() {
        timer.suspend()
    }
    
    func add(currencyPair: CurrencyPair) {
        currencyPairsRepository.add(currencyPairCode: currencyPair.pairName)
    }
    
    func delete(currencyPair: CurrencyPair) {
        currencyPairsRepository.delete(currencyPairCode: currencyPair.pairName)
    }
    
    deinit {
        timer.setEventHandler(handler: nil)
        timer.cancel()
        // https://forums.developer.apple.com/thread/15902
        timer.resume()
    }
}

// MARK: - Private
private extension PairsViewModelImpl {
    func pollCurrencyPairs() {
        guard currentTask?.state != .running else { return }
        let pairKeys = currencyPairsRepository.getCurrencyPairs()
        currentTask = currencyService.getRates(pairs: pairKeys) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(currencyPairs):
                self.onChange?(currencyPairs)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
