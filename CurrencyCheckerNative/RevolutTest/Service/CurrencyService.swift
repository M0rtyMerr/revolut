//
//  CurrencyService.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import Foundation

protocol CurrencyService {
    func getCurrencies() -> [Currency]
    func getRates(pairs: [String], _ competionHandler: @escaping ((Result<[CurrencyPair], RevolutError>) -> Void)) -> URLSessionDataTask?
 }
