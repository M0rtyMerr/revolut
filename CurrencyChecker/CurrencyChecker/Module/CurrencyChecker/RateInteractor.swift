//
//  CurrencyInteractor.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RateInteractor {
    func get(base: String) -> Observable<Rate>
}

class RateInteractorImpl: RateInteractor {
    private let rateService: RateService
    private let scheduler: SchedulerType
    private let newRequest = PublishRelay<()>()
    
    init(rateService: RateService, scheduler: SchedulerType) {
        self.rateService = rateService
        self.scheduler = scheduler
    }
    
    func get(base: String) -> Observable<Rate> {
        newRequest.accept(())
        return Observable<Int>.interval(1, scheduler: scheduler)
                              .flatMapLatest { _ in self.rateService.get(base: base) }
                              .takeUntil(newRequest)
    }
}
