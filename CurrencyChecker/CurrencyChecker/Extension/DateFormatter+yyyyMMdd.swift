//
//  DateFormatter+yyyyMMdd.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//


import Then

extension DateFormatter {
    static let yyyyMMdd = DateFormatter().then {
        $0.calendar = Calendar(identifier: .iso8601)
        $0.dateFormat = "yyyy-MM-dd"
    }
}
