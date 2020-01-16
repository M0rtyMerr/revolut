//
//  MockViewController.swift
//  RevolutTestTests
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class MockViewController: UIViewController {
    var presentWasCalled: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentWasCalled = viewControllerToPresent
    }
}
