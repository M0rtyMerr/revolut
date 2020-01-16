//
//  CurrencyAPI.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import Moya

enum RateAPI {
    case get(base: String)
}

// MARK: - TargetType
extension RateAPI: TargetType {
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://revolut.duckdns.org")!
    }

    var path: String {
        return "/latest"
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Util.getJSON(name: "CurrencyResponse_EUR")
    }

    var task: Task {
        switch self {
        case let .get(base):
            return .requestParameters(parameters: ["base": base], encoding: URLEncoding.queryString)
        }
    }

    // swiftlint:disable:next discouraged_optional_collection
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
