//
//  RateTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
@testable import CurrencyChecker

class RateTest: QuickSpec {
    private let decoder = JSONDecoder()
    
    override func spec() {
        super.spec()
        describe("Mapping test") {
            it("maps correctly") {
                let rate = try! self.decoder.decode(Rate.self, from: Util.getJSON(name: "CurrencyResponse_EUR"))
                
                expect(rate.base) == "EUR"
                expect(rate.rates).toNot(beEmpty())
            }
        }
    }
    
}
