//
//  NibInstantiatable.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

protocol NibInstantiatable: UIView {
    static var nibName: String { get }
}

extension NibInstantiatable {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Self
    }
}
