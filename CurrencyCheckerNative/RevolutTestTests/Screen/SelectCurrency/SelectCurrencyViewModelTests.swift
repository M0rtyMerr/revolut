//
//  SelectCurrencyViewModelTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class SelectCurrencyViewModelTests: XCTestCase {
    private var mockCurrencyService: MockCurrencyService!
    private var selectCurrencyViewModel: SelectCurrencyViewModel!
    private var mockCurrencyPairsRepository: MockCurrencyPairsRepository!
    
    override func setUp() {
        super.setUp()
        mockCurrencyService = MockCurrencyService()
        mockCurrencyPairsRepository = MockCurrencyPairsRepository()
        selectCurrencyViewModel = makeSelectCurrencyViewModel()
    }
    
    override func tearDown() {
        mockCurrencyService = nil
        mockCurrencyPairsRepository = nil
        selectCurrencyViewModel = nil
        super.tearDown()
    }
    
    func testAllCurrenciesEnabledIfSelectedIsNil() {
        // Given
        mockCurrencyService.currencies = Random.currencies
        let expectedCurrencies = mockCurrencyService.currencies.map { CurrencyCellDto(currency: $0, isEnabled: true) }
        // When
        let actualCurrencies = selectCurrencyViewModel.getCurrencies()
        // Then
        XCTAssertEqual(expectedCurrencies, actualCurrencies)
    }
    
    func testSelectedCurrencyDisabledIfSelectedIsNotNil() {
        // Given
        let selectedCurrency = Random.currency
        selectCurrencyViewModel = makeSelectCurrencyViewModel(selectedCurrency: selectedCurrency)
        mockCurrencyService.currencies = Random.currencies + [selectedCurrency]
        let expectedCurrencyDtos = mockCurrencyService.currencies.map {
            CurrencyCellDto(currency: $0, isEnabled: $0 != selectedCurrency)
        }
        // When
        let actualCurrencyDtos = selectCurrencyViewModel.getCurrencies()
        // Then
        XCTAssertEqual(actualCurrencyDtos, expectedCurrencyDtos)
    }
    
    func testAlreadyAddedCurrenciesDisabled() {
        // Given
        let selectedCurrency = Random.currency
        selectCurrencyViewModel = makeSelectCurrencyViewModel(selectedCurrency: selectedCurrency)
        let addedCurrencyPairTitles = Random.currencyPairTitles.map { String((selectedCurrency.code + $0).prefix(6)) }
        mockCurrencyPairsRepository.currencyPairTitles = addedCurrencyPairTitles
        mockCurrencyService.currencies = addedCurrencyPairTitles.map { Currency(code: String($0.suffix(3))) }
        let expectedCurrenciesDtos = mockCurrencyService.currencies.map { CurrencyCellDto(currency: $0, isEnabled: false) }
        // When
        let actualCurrencyDtos = selectCurrencyViewModel.getCurrencies()
        // Then
        XCTAssertEqual(actualCurrencyDtos, expectedCurrenciesDtos)
    }
}

// MARK: - Private
private extension SelectCurrencyViewModelTests {
    func makeSelectCurrencyViewModel(selectedCurrency: Currency? = nil) -> SelectCurrencyViewModel {
        return SelectCurrencyViewModelImpl(
            selectedCurrency: selectedCurrency,
            currencyService: mockCurrencyService,
            currencyPairsRepository: mockCurrencyPairsRepository
        )
    }
}

