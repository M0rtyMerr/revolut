//
//  CurrencyServiceTest.swift
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

class CurrencyServiceTest: QuickSpec {
    override func spec() {
        super.spec()
        let currencyService = CurrencyService(currencyProvider: MoyaProvider<CurrencyAPI>(stubClosure: MoyaProvider.immediatelyStub))
        
        describe("Currency service test") {
            it("returns single, which completes successfully") {
                let currency = try! currencyService.get(base: "EUR").toBlocking().single()
                
                expect(currency.base) == "EUR"
            }
        }
    }
}
