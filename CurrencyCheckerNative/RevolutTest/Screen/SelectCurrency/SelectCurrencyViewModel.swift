//
//  SelectCurrencyViewModel.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

protocol SelectCurrencyViewModel {
    func getCurrencies() -> [CurrencyCellDto]
}
