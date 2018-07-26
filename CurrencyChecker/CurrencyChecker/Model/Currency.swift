//
//  Currency.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import RxDataSources

struct Currency: Equatable {
    let name: String
    let value: Double
}

extension Currency: IdentifiableType {
    typealias Identity = String

    var identity: String {
        return name
    }
}
