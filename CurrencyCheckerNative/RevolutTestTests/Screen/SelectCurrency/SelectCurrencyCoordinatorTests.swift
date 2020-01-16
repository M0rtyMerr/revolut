//
//  SelectCurrencyCoordinatorTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class SelectCurrencyCoordinatorTests: XCTestCase {
    private var selectCurrencyCoordinator: SelectCurrencyCoordinatorImpl!
    private var mockCurrencyService: MockCurrencyService!
    private var mockCurrencyPairsRepository: MockCurrencyPairsRepository!
    
    override func setUp() {
        super.setUp()
        mockCurrencyService = MockCurrencyService()
        mockCurrencyPairsRepository = MockCurrencyPairsRepository()
        selectCurrencyCoordinator = SelectCurrencyCoordinatorImpl(currencyService: mockCurrencyService, currencyPairsRepository: mockCurrencyPairsRepository)
    }
    
    override func tearDown() {
        mockCurrencyService = nil
        mockCurrencyPairsRepository = nil
        selectCurrencyCoordinator = nil
        super.tearDown()
    }
    
    func testCoordinatorPresentSelectCurrencyViewController() {
        // Given
        let mockViewController = MockViewController()
        // When
        selectCurrencyCoordinator.start(on: mockViewController)
        // Then
        let presentedViewController = mockViewController.presentWasCalled as? UINavigationController
        XCTAssertTrue(presentedViewController?.viewControllers.first is SelectCurrencyViewController)
    }
}
