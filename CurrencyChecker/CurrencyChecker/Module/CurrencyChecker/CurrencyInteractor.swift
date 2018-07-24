//
//  CurrencyInteractor.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import RxSwift

class CurrencyInteractor {
    private let currencyService: CurrencyService
    private let scheduler: SchedulerType
    
    init(currencyService: CurrencyService, scheduler: SchedulerType) {
        self.currencyService = currencyService
        self.scheduler = scheduler
    }
    
    var base = "EUR"
    
    func get() -> Observable<Currency> {
        return Observable<Int>.interval(1, scheduler: scheduler)
                              .flatMap { _ in self.currencyService.get(base: self.base) }
    }
}
