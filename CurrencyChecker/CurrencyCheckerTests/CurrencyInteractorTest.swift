//
//  CurrencyInteractorTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxSwift
import RxSwiftExt
import RxTest
@testable import CurrencyChecker

class CurrencyInteractorTest: QuickSpec {
    override func spec() {
        super.spec()
        describe("Currency interactor test") {
            let currencyProvider = MoyaProvider<CurrencyAPI>(stubClosure: MoyaProvider.immediatelyStub)
            let currencyService = CurrencyService(currencyProvider: currencyProvider)
            
            var currencyInteractor: CurrencyInteractor!
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            var observer: TestableObserver<Currency>!

            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: 0)
                currencyInteractor = CurrencyInteractor(currencyService: currencyService, scheduler: scheduler)
                observer = scheduler.createObserver(Currency.self)
            }
            
            it("returns observable which emits every second") {
                let expectedCount = 10
                scheduler.scheduleAt(0) {
                    currencyInteractor.get()
                        .subscribe(observer)
                        .disposed(by: disposeBag)
                }
                
                scheduler.advanceTo(expectedCount)
                
                expect(observer.events.count) == expectedCount
            }
            
            it("returns different currencies depending on base") {
                let generalCount = 10
                scheduler.scheduleAt(0) {
                    currencyInteractor.get()
                        .subscribe(observer)
                        .disposed(by: disposeBag)
                }
                scheduler.scheduleAt(generalCount / 2 + 1) {
                    currencyInteractor.base = "AUD"
                }
                
                scheduler.advanceTo(generalCount)
                
                expect(observer.events.compactMap { $0.value.element }.filter { $0.base == "EUR" }.count) == generalCount / 2
                
            }
        }
    }
}
