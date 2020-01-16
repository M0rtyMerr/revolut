//
//  CurrencyTableViewCell.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var codeLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var disabledOverlayView: UIView!
    
    func configure(currencyCellDto: CurrencyCellDto) {
        iconImageView.image = UIImage(named: currencyCellDto.currency.code)
        codeLabel.text = currencyCellDto.currency.code
        titleLabel.text = currencyCellDto.currency.title
        disabledOverlayView.isHidden = currencyCellDto.isEnabled
    }
}
