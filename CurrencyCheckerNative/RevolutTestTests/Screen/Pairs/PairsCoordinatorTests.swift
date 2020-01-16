//
//  PairsCoordinatorTests.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import RevolutTest

final class PairsCoordinatorTests: XCTestCase {
    private var pairsCoordinator: PairsCoodinator!
    private var window: UIWindow!
    private var mockCurrencyService: MockCurrencyService!
    private var mockCurrencyPairsRepository: MockCurrencyPairsRepository!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        mockCurrencyService = MockCurrencyService()
        mockCurrencyPairsRepository = MockCurrencyPairsRepository()
        pairsCoordinator = PairsCoordinatorImpl(
            window: window,
            currencyService: mockCurrencyService,
            currencyPairsRepository: mockCurrencyPairsRepository
        )
    }
    
    override func tearDown() {
        mockCurrencyService = nil
        mockCurrencyPairsRepository = nil
        pairsCoordinator = nil
        window = nil
        super.tearDown()
    }
    
    func testPairsControllerPresentedAfterStart() {
        // When
        pairsCoordinator.start()
        // Then
        let rootViewController = window.rootViewController as? UINavigationController
        XCTAssertTrue(rootViewController?.viewControllers.first is PairsViewController)
    }
}
