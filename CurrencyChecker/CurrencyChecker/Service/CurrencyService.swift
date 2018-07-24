//
//  CurrencyService.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Moya
import RxSwift

class CurrencyService {
    private let currencyProvider: MoyaProvider<CurrencyAPI>
    
    init(currencyProvider: MoyaProvider<CurrencyAPI>) {
        self.currencyProvider = currencyProvider
    }
    
    func get(base: String) -> Single<Currency> {
        return currencyProvider.rx.request(.get(base: base))
                                  .map(Currency.self)
    }
}

