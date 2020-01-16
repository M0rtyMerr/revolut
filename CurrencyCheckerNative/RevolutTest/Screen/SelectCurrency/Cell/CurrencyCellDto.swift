//
//  CurrencyCellDto.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

struct CurrencyCellDto {
    let currency: Currency
    let isEnabled: Bool
}

// MARK: - Equatable
extension CurrencyCellDto: Equatable {
}
