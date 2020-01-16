//
//  Currency.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

struct Currency {
    let code: String
}

extension Currency {
    var title: String {
        return Locale.current.localizedString(forCurrencyCode: code) ?? ""
    }
}

// MARK: - Hashable
extension Currency: Hashable {
}
