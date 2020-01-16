//
//  SelectCurrencyViewModelImpl.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

final class SelectCurrencyViewModelImpl: SelectCurrencyViewModel {
    private let selectedCurrency: Currency?
    private let currencyService: CurrencyService
    private let currencyPairsRepository: CurrencyPairsRepository
    
    init(selectedCurrency: Currency? = nil, currencyService: CurrencyService, currencyPairsRepository: CurrencyPairsRepository) {
        self.selectedCurrency = selectedCurrency
        self.currencyService = currencyService
        self.currencyPairsRepository = currencyPairsRepository
    }
    
    func getCurrencies() -> [CurrencyCellDto] {
        let currencies = currencyService.getCurrencies()
        guard let selectedCurrency = selectedCurrency else {
            return currencies.map { CurrencyCellDto(currency: $0, isEnabled: true) }
        }
        let disabledCurrencies = currencyPairsRepository.getCurrencyPairs()
            .filter { $0.prefix(3) == selectedCurrency.code }
            .map { String($0.suffix(3)) }
            .map(Currency.init) 
        return currencies.map {
            CurrencyCellDto(currency: $0, isEnabled: !disabledCurrencies.contains($0) && $0 != selectedCurrency)
        }
    }
}
