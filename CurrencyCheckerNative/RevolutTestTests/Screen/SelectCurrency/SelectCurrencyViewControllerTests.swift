//
//  SelectCurrencyViewControllerTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class SelectCurrencyViewControllerTests: XCTestCase {
    private var mockSelectCurrencyViewModel: MockSelectCurrencyViewModel!
    private var selectCurrencyViewController: SelectCurrencyViewController!
    
    override func setUp() {
        super.setUp()
        mockSelectCurrencyViewModel = MockSelectCurrencyViewModel()
        selectCurrencyViewController = SelectCurrencyViewController.instantiate()
        selectCurrencyViewController.viewModel = mockSelectCurrencyViewModel
        _ = selectCurrencyViewController.view
    }
    
    override func tearDown() {
        mockSelectCurrencyViewModel = nil
        selectCurrencyViewController = nil
        super.tearDown()
    }
    
    func testCallonSelectCurrencyAfterCellSelection() {
        // Given
        let expectedCurrency = Random.currency
        mockSelectCurrencyViewModel.currencyCellDtos = [CurrencyCellDto(currency: expectedCurrency, isEnabled: true)]
        var actualCurrency: Currency?
        selectCurrencyViewController.onSelectCurrency = {
            actualCurrency = $0
        }
        selectCurrencyViewController.viewWillAppear(false)
        // When
        selectCurrencyViewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertEqual(actualCurrency, expectedCurrency)
    }
}
