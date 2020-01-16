//
//  Util.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 27/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

enum Util {
    static func json(named name: String) -> Data {
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else {
            return "".data(using: String.Encoding.utf8)!
        }
        return try! Data(contentsOf: URL(fileURLWithPath: filePath))
    }
}
