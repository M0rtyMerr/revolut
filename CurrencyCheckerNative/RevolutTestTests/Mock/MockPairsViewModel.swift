//
//  MockPairsViewModel.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

@testable import RevolutTest

final class MockPairsViewModel: PairsViewModel {
    var onChange: (([CurrencyPair]) -> Void)?
    var onError: ((RevolutError) -> Void)?
    var wasViewWillAppearCalled = false
    var wasViewWillDisappearCalled = false
    var deleteWasCalled: CurrencyPair?
    
    func viewWillAppear() {
        wasViewWillAppearCalled = true
    }
    
    func viewWillDisappear() {
        wasViewWillDisappearCalled = false
    }
    
    func add(currencyPair: CurrencyPair) {
    }
    
    func delete(currencyPair: CurrencyPair) {
        deleteWasCalled = currencyPair
    }
}

