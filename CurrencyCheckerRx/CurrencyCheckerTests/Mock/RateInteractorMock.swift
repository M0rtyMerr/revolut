//
//  RateInteractorMock.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 26/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import RxSwift
@testable import CurrencyChecker

class RateInteractorMock: RateInteractor {
    var stubRates = [String: Double]()

    func get(base: String) -> Observable<Rate> {
        return .just(Rate(base: base, rates: stubRates))
    }
}
