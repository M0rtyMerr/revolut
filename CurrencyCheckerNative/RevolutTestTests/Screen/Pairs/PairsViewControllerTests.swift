//
//  PairsViewControllerTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class PairsViewControllerTests: XCTestCase {
    private var mockPairsViewModel: MockPairsViewModel!
    private var pairsViewController: PairsViewController!
    
    override func setUp() {
        super.setUp()
        mockPairsViewModel = MockPairsViewModel()
        pairsViewController = PairsViewController.instantiate()
        pairsViewController.pairsViewModel = mockPairsViewModel
        _ = pairsViewController.view
    }
    
    override func tearDown() {
        mockPairsViewModel = nil
        pairsViewController = nil
        super.tearDown()
    }
    
    func testDeleteCurrencyCalledAfterSwipeToDelete() {
        // Given
        let expectedCurrencyPair = Random.currencyPair
        mockPairsViewModel.onChange?([expectedCurrencyPair])
        // When
        pairsViewController.tableView(UITableView(), commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertEqual(mockPairsViewModel.deleteWasCalled, expectedCurrencyPair)
    }
}

