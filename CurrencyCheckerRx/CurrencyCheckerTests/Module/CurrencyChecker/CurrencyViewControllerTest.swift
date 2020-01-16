//
//  CurrencyViewControllerTest.swift
//  CurrencyCheckerTests
//
//  Created by Антон Назаров on 26/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxSwift
import RxTest
import ReactorKit
@testable import CurrencyChecker

class CurrencyViewControllerTest: QuickSpec {
    override func spec() {
        super.spec()

        describe("View controller test") {
            context("Stubbed reactor") {
                var reactor: CurrencyReactor!
                let viewController = CurrencyTableViewController()
                _ = viewController.view //outlets
                let rateInteractorMock = RateInteractorMock()

                beforeEach {
                    reactor = CurrencyReactor(rateInteractor: rateInteractorMock)
                    reactor.stub.isEnabled = true
                    viewController.reactor = reactor
                }

                it("updates base label") {
                    let newBase = "RUB"
                    reactor.stub.state.value = CurrencyReactor.State(value: 0.0, rates: [String: Double](), currencies: [Currency(name: newBase, value: 4.0)])

                    expect(viewController.base.text) == newBase
                }
            }
        }
    }
}
