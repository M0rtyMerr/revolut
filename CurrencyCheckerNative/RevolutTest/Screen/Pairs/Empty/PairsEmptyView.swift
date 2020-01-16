//
//  PairsEmptyView.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class PairsEmptyView: UIView, NibInstantiatable {
    var onAdd: (() -> Void)?
    
    @IBAction private func add() {
        onAdd?()
    }
}
