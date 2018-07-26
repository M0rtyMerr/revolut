//
//  CurrenciesSection.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import RxDataSources

struct CurrenciesSection {
    var title: String
    var items: [Currency]
}

extension CurrenciesSection: AnimatableSectionModelType {
    typealias Item = Currency
    
    var identity: String {
        return title
    }
    
    init(original: CurrenciesSection, items: [Currency]) {
        self = original
        self.items = items
    }
}

