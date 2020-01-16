//
//  PairsViewModelTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class PairsViewModelTests: XCTestCase {
    private var mockCurrencyService: MockCurrencyService!
    private var pairsViewModel: PairsViewModel!
    private var mockCurrencyPairsRepository: MockCurrencyPairsRepository!
    private var timer: DispatchSourceTimer!
    
    override func setUp() {
        super.setUp()
        mockCurrencyService = MockCurrencyService()
        mockCurrencyPairsRepository = MockCurrencyPairsRepository()
        timer = DispatchSource.makeTimerSource(queue: .main)
        pairsViewModel = PairsViewModelImpl(
            currencyService: mockCurrencyService,
            currencyPairsRepository: mockCurrencyPairsRepository,
            timer: timer
        )
    }
    
    override func tearDown() {
        pairsViewModel.viewWillDisappear()
        pairsViewModel = nil
        mockCurrencyService = nil
        mockCurrencyPairsRepository = nil
        super.tearDown()
    }
    
    func testDeleteTriggerRepositoryDelete() {
        // Given
        let expectedCurrencyPair = Random.currencyPair
        // When
        pairsViewModel.delete(currencyPair: expectedCurrencyPair)
        // Then
        XCTAssertEqual(expectedCurrencyPair.pairName, mockCurrencyPairsRepository.wasDeleteCalled)
    }
    
    func testAddTriggerRepositoryAdd() {
        // Given
        let expectedCurrencyPair = Random.currencyPair
        // When
        pairsViewModel.add(currencyPair: expectedCurrencyPair)
        // Then
        XCTAssertEqual(expectedCurrencyPair.pairName, mockCurrencyPairsRepository.wasAddCalled)
    }
    
    func testServiceCalledWithSavedCurrencyPairTiles() {
        // Given
        let expectedCurrencyPairTitles = Random.currencyPairTitles
        mockCurrencyPairsRepository.currencyPairTitles = expectedCurrencyPairTitles
        let expectation = XCTestExpectation(description: "serviceCalledWithSavedCurrencyPairTiles")
        pairsViewModel.onChange = { _ in expectation.fulfill() }
        // When
        pairsViewModel.viewWillAppear()
        wait(for: [expectation], timeout: 5)
        // Then
        XCTAssertEqual(expectedCurrencyPairTitles, mockCurrencyService.wasGetRatesCalled)
    }
    
    func testOnChangedCalledOnTimer() {
        // Given
        let expectedCurrencyPairs = Random.currencyPairs
        mockCurrencyService.currencyPairs = expectedCurrencyPairs
        var actualCurrencyPairs: [CurrencyPair]?
        let expectation = XCTestExpectation(description: "testOnChangedCalledOnTimer")
        pairsViewModel.onChange = {
            actualCurrencyPairs = $0
            expectation.fulfill()
        }
        // When
        pairsViewModel.viewWillAppear()
        wait(for: [expectation], timeout: 5)
        // Then
        XCTAssertEqual(actualCurrencyPairs, expectedCurrencyPairs)
    }
}
