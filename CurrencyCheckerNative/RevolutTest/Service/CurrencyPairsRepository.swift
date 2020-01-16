//
//  CurrencyPairsRepository.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

protocol CurrencyPairsRepository {
    func getCurrencyPairs() -> [String]
    func add(currencyPairCode: String)
    func delete(currencyPairCode: String)
    func deleteAll()
}
