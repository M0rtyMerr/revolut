//
//  Rate.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Foundation

struct Rate: Decodable {
    let base: String
    let rates: [String: Double]
}
