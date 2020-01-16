//
//  Random.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation
@testable import RevolutTest

enum Random {
    static var int: Int {
        return Int.random(in: 1...10)
    }
    
    static var string: String {
        return UUID().uuidString
    }
    
    static var code: String {
        return String(Random.string.prefix(3))
    }
    
    static func array<T>(_ factory: @autoclosure () -> T) -> [T] {
        var array = [T]()
        for _ in 0...Random.int {
            array.append(factory())
        }
        return array
    }
    
    static var currency: Currency {
        return Currency(code: Random.code)
    }
    
    static var currencies: [Currency] {
        return array(Random.currency)
    }
    
    static var currencyPair: CurrencyPair {
        return CurrencyPair(sourceCurrency: Random.currency, targetCurrency: Random.currency)
    }
    
    static var currencyPairs: [CurrencyPair] {
        return array(currencyPair)
    }
    
    static var currencyPairTitles: [String] {
        return array(String(Random.string.prefix(6)))
    }
}
