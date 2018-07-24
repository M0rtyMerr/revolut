//
//  CurrencyTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
@testable import CurrencyChecker

class CurrencyTest: QuickSpec {
    private let decoder = JSONDecoder()
    
    override func spec() {
        super.spec()
        describe("Mapping test") {
            it("maps correctly") {
                let currency = try! self.decoder.decode(Currency.self, from: Util.getJSON(name: "CurrencyResponse"))
                
                expect(currency.base) == "EUR"
                expect(currency.date.timeIntervalSince1970) == 1532034000.0
                expect(currency.rates).toNot(beEmpty())
            }
        }
    }
    
}
