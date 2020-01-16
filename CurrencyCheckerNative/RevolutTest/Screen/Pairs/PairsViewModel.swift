//
//  PairsViewModel.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

protocol PairsViewModel {
    var onChange: (([CurrencyPair]) -> Void)? { get set }
    
    func viewWillAppear()
    func viewWillDisappear()
    func add(currencyPair: CurrencyPair)
    func delete(currencyPair: CurrencyPair)
}
