//
//  CurrencyServiceImpl.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

final class CurrencyServiceImpl: CurrencyService {
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func getCurrencies() -> [Currency] {
        let currencies = try? jsonDecoder.decode(Array<String>.self, from: Util.json(named: "currencies"))
        return currencies?.map(Currency.init) ?? []
    }
    
    func getRates(pairs: [String], _ competionHandler: @escaping ((Result<[CurrencyPair], RevolutError>) -> Void)) -> URLSessionDataTask? {
        guard !pairs.isEmpty else {
            competionHandler(.success([]))
            return nil
        }
        let params = pairs.joined(separator: "&pairs=")
        guard let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios?pairs=\(params)") else {
            competionHandler(.failure(.networkError))
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            switch (data, error) {
            case (_, .some):
                competionHandler(.failure(.networkError))
            case let (.some(data), nil):
                
                guard let pairsDictionary = try? self.jsonDecoder.decode(Dictionary<String, Double>.self, from: data) else {
                    competionHandler(.failure(.parsing))
                    return
                }
                competionHandler(.success(pairsDictionary.map(CurrencyPair.init).sorted()))
            case (nil, nil):
                competionHandler(.failure(.inconsistentBehavior))
            }
        }
        task.resume()
        return task
    }
}
