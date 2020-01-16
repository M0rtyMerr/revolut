//
//  MockCurrencyPairsRepository.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

@testable import RevolutTest

final class MockCurrencyPairsRepository: CurrencyPairsRepository {
    var currencyPairTitles = [String]()
    var wasAddCalled: String?
    var wasDeleteCalled: String?
    
    func getCurrencyPairs() -> [String] {
        return currencyPairTitles
    }
    
    func add(currencyPairCode: String) {
        wasAddCalled = currencyPairCode
    }
    
    func delete(currencyPairCode: String) {
        wasDeleteCalled = currencyPairCode
    }
    
    func deleteAll() {
    }
}
