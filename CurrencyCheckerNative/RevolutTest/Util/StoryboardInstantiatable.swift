//
//  StoryboardInstantiatable.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiatable {
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else{
            fatalError("failed to load \(storyboardName) storyboard file.")
        }
        return vc
    }
}
