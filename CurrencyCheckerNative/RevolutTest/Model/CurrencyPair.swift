//
//  CurrencyPair.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

struct CurrencyPair {
    let pairName: String
    let rate: Double
}

extension CurrencyPair {
    init(sourceCurrency: Currency, targetCurrency: Currency) {
        pairName = sourceCurrency.code + targetCurrency.code
        rate = 0.0
    }
    
    var sourceCurrency: Currency {
        return Currency(code: String(pairName.prefix(3)))
    }
    
    var targetCurrency: Currency {
        return Currency(code: String(pairName.suffix(3)))
    }
}

extension CurrencyPair: Comparable {
    static func < (lhs: CurrencyPair, rhs: CurrencyPair) -> Bool {
        return lhs.pairName < rhs.pairName
    }
}
