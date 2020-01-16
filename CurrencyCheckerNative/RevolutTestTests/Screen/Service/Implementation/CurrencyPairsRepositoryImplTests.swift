//
//  CurrencyPairsRepositoryImplTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class CurrencyPairsRepositoryImplTests: XCTestCase {
    private var currencyPairsRepository: CurrencyPairsRepository!
    
    override func setUp() {
        super.setUp()
        currencyPairsRepository = CurrencyPairsRepositoryImpl(key: "test")
        currencyPairsRepository.deleteAll()
    }
    
    override func tearDown() {
        currencyPairsRepository = nil
        super.tearDown()
    }
    
    func testAdd() {
        // Given
        let expectedCurrencyPairTitle = Random.string
        // When
        currencyPairsRepository.add(currencyPairCode: expectedCurrencyPairTitle)
        // Then
        let actualCurrencyPairsTitle = currencyPairsRepository.getCurrencyPairs()
        XCTAssertEqual([expectedCurrencyPairTitle], actualCurrencyPairsTitle)
    }
    
    func testDelete() {
        // Given
        let currencyPairTitle = Random.string
        // When
        currencyPairsRepository.add(currencyPairCode: currencyPairTitle)
        currencyPairsRepository.delete(currencyPairCode: currencyPairTitle)
        // Then
        let actualCurrencyPairsTitle = currencyPairsRepository.getCurrencyPairs()
        XCTAssertEqual(actualCurrencyPairsTitle, [])
    }    
}
