//
//  CurrencyService.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Moya
import RxSwift

class RateService {
    private let rateProvider: MoyaProvider<RateAPI>

    init(rateProvider: MoyaProvider<RateAPI>) {
        self.rateProvider = rateProvider
    }

    func get(base: String) -> Single<Rate> {
        return rateProvider.rx.request(.get(base: base))
                              .map(Rate.self)
    }
}
