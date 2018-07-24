//
//  Util.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Foundation

class Util {
    private init() {
    }
    
    static func getJSON(name: String) -> Data {
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path(name: name, type: "json")))
        } catch {
            fatalError("Can't read \(name)")
        }
    }
    
    static func path(name: String, type: String) -> String {
        guard let path = Bundle(for: self).path(forResource: name, ofType: type) else {
            fatalError("Error while reading \(name)")
        }
        return path
    }
}
