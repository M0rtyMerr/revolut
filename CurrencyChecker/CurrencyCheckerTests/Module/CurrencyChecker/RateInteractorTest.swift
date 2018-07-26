//
//  RateInteractorTest.swift
//  RateCheckerTests
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

class RateInteractorTest: QuickSpec {
    override func spec() {
        super.spec()
        describe("Rate interactor test") {
            let rateProvider = MoyaProvider<RateAPI>(stubClosure: MoyaProvider.immediatelyStub)
            let rateService = RateService(rateProvider: rateProvider)
            
            var rateInteractor: RateInteractor!
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            var observer: TestableObserver<Rate>!

            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: 0)
                rateInteractor = RateInteractorImpl(rateService: rateService, scheduler: scheduler)
                observer = scheduler.createObserver(Rate.self)
            }
            
            it("returns observable which emits every second") {
                let expectedCount = 10
                scheduler.scheduleAt(0) {
                    rateInteractor.get(base: "EUR")
                        .subscribe(observer)
                        .disposed(by: disposeBag)
                }
                
                scheduler.advanceTo(expectedCount)
                
                expect(observer.events.count) == expectedCount
            }
        }
    }
}
