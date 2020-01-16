//
//  RevolutError.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

enum RevolutError: Error {
    case parsing
    case inconsistentBehavior
    case networkError
}

// MARK: - LocalizedError
extension RevolutError: LocalizedError {
    var errorDescription: String? {
        return "Something went wrong, we will fix it as soon as possible!"
    }
}
