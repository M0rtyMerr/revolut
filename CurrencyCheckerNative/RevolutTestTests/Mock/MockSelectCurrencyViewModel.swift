//
//  MockSelectCurrencyViewModel.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

@testable import RevolutTest

final class MockSelectCurrencyViewModel: SelectCurrencyViewModel {
    var currencyCellDtos = [CurrencyCellDto]()
    
    func getCurrencies() -> [CurrencyCellDto] {
        return currencyCellDtos
    }
}
