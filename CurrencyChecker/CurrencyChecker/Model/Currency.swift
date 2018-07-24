//
//  Currency.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Foundation

struct Currency {
    let base: String
    let date: Date
    let rates: [String: Double]
}

extension Currency: Decodable {
    enum CodingKeys: String, CodingKey {
        case base
        case date
        case rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base: String = try container.decode(String.self, forKey: .base)
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter.yyyyMMdd
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Invalid date")
        }
        let rates: [String: Double] = try container.decode([String: Double].self, forKey: .rates)
        
        self.init(base: base, date: date, rates: rates)
    }
}

