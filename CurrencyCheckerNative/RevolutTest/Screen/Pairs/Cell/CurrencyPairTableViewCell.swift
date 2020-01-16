//
//  CurrencyPairTableViewCell.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class CurrencyPairTableViewCell: UITableViewCell {
    @IBOutlet private var sourceCurrencyValueLabel: UILabel!
    @IBOutlet private var targetCurrencyValueLabel: UILabel!
    @IBOutlet private var sourceCurrencyTitleLabel: UILabel!
    @IBOutlet private var targetCurrencyTitleLabel: UILabel!
    @IBOutlet private var targetCurrencyCodeLabel: UILabel!
    
    func configure(currencyPair: CurrencyPair) {
        sourceCurrencyValueLabel.text = "1 \(currencyPair.sourceCurrency.code)"
        targetCurrencyValueLabel.text = String(currencyPair.rate)
        sourceCurrencyTitleLabel.text = currencyPair.sourceCurrency.title
        targetCurrencyTitleLabel.text = currencyPair.targetCurrency.title
        targetCurrencyCodeLabel.text = currencyPair.targetCurrency.code
    }
}
