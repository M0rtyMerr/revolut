//
//  CurrencyAPI.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Moya

enum CurrencyAPI {
    case get(base: String)
}

// MARK: - TargetType
extension CurrencyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://revolut.duckdns.org")!
    }
    
    var path: String {
        return "/latest"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Util.getJSON(name: "CurrencyResponse")
    }
    
    var task: Task {
        switch self {
        case let .get(base):
            return .requestParameters(parameters: ["base": base], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
