//
//  CurrencyReactorTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 25/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxSwift
import RxTest
import ReactorKit
@testable import CurrencyChecker

class CurrenyRouterTest: QuickSpec {
    override func spec() {
        super.spec()
        describe("Reactor test") {
            context("stubbed interactor") {
                let mockRateInteractor = RateInteractorMock()
                mockRateInteractor.stubRates = ["RUB": 2.0, "BLG": 1.0]
                let someCurrency = Currency(name: "ABS", value: 1.0)
                var reactor: CurrencyReactor!
                beforeEach {
                    reactor = CurrencyReactor(rateInteractor: mockRateInteractor)
                }
                
                it("updates rates after selection of currency") {
                    reactor.action.onNext(.select(currency: someCurrency))
                    
                    expect(reactor.currentState.currencies).toNot(beEmpty())
                }
                
                it("change currencies after selection of currency") {
                    reactor.action.onNext(.select(currency: someCurrency))
                    
                    expect(reactor.currentState.currencies.count) == 3
                }
                
                it("sets selected currency as first after selection of currency") {
                    reactor.action.onNext(.select(currency: someCurrency))
                    
                    expect(reactor.currentState.currencies[0].name) == someCurrency.name
                }
                
                it("update value after typing new value") {
                    let newValue = 10.0
                    
                    reactor.action.onNext(.type(value: newValue))
                    
                    expect(reactor.currentState.currencies[0].value) == newValue
                }
                
                it("update currencies after new value") {
                    reactor.action.onNext(.select(currency: someCurrency))
                    let beforeCurrencies = reactor.currentState.currencies
                    let newValue = 10.0
                    
                    reactor.action.onNext(.type(value: newValue))
                    
                    reactor.currentState.currencies.suffix(from: 1).forEach { currency in
                        expect(currency.value) == beforeCurrencies.first { $0.name == currency.name }!.value * newValue
                    }
                }
            }
        }
    }
}
