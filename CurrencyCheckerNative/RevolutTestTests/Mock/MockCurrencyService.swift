//
//  MockCurrencyService.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class MockCurrencyService: CurrencyService {
    var currencies = [Currency]()
    var currencyPairs = [CurrencyPair]()
    var wasGetRatesCalled: [String]?
    
    func getCurrencies() -> [Currency] {
        return currencies
    }
    
    func getRates(pairs: [String], _ competionHandler: @escaping ((Result<[CurrencyPair], RevolutError>) -> Void)) -> URLSessionDataTask? {
        wasGetRatesCalled = pairs
        competionHandler(.success(currencyPairs))
        return nil
    }
}
