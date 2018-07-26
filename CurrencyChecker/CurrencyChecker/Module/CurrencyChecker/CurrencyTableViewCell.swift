//
//  CurrencyTableViewCell.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import UIKit
import RxSwift

class CurrencyTableViewCell: UITableViewCell {
    // swiftlint:disable:next private_outlet
    @IBOutlet var value: UITextField!
    @IBOutlet private var name: UILabel!
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func render(currency: Currency, enabled: Bool) {
        value.text = String(currency.value)
        name.text = currency.name
        value.isEnabled = enabled
    }
}
