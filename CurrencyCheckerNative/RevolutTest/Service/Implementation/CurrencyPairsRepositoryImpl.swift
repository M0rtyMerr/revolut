//
//  CurrencyPairsRepositoryImpl.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

final class CurrencyPairsRepositoryImpl: CurrencyPairsRepository {
    private let key: String
    private let serialQueue = DispatchQueue(label: "CurrencyPairsRepositoryImpl")
    
    init(key: String) {
        self.key = key
    }
    
    func getCurrencyPairs() ->  [String] {
        var currencyPairs = [String]()
        serialQueue.sync {
            currencyPairs = UserDefaults.standard.stringArray(forKey: key) ?? []
        }
        return currencyPairs
    }
    
    func add(currencyPairCode: String) {
        let existingPairs = getCurrencyPairs()
        save(currencyPairs: existingPairs + [currencyPairCode])
    }
    
    func delete(currencyPairCode: String) {
        let existingPairs = getCurrencyPairs()
        save(currencyPairs: existingPairs.filter { $0 != currencyPairCode })
    }
    
    func deleteAll() {
        save(currencyPairs: [])
    }
}

// MARK: - Private
private extension CurrencyPairsRepositoryImpl {
    func save(currencyPairs: [String]) {
        serialQueue.sync {
            UserDefaults.standard.set(currencyPairs, forKey: key)
        }
    }
}
