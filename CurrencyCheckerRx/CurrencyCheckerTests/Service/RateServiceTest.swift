//
//  RateServiceTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxBlocking
@testable import CurrencyChecker

class RateServiceTest: QuickSpec {
    override func spec() {
        super.spec()
        let rateService = RateService(rateProvider: MoyaProvider<RateAPI>(stubClosure: MoyaProvider.immediatelyStub))

        describe("Currency service test") {
            it("returns single, which completes successfully") {
                let currency = try! rateService.get(base: "EUR").toBlocking().single()

                expect(currency.base) == "EUR"
            }
        }
    }
}
