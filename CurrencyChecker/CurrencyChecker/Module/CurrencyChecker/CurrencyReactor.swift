//
//  CurrencyReactor.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 24/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import ReactorKit
import RxSwift

class CurrencyReactor: Reactor {
    enum Action {
        case select(currency: Currency)
        case type(value: Double)
    }
    
    enum Mutation {
        case rateLoaded(Rate)
        case valueUpdated(Double)
    }
    
    struct State {
        var value: Double
        var rates: [String: Double]
        var currencies: [Currency]
    }
    
    private let rateInteractor: RateInteractor
    let initialState = State(value: 1.0, rates: [String: Double](), currencies: [Currency(name: "EUR", value: 1.0)])
    
    init(rateInteractor: RateInteractor) {
        self.rateInteractor = rateInteractor
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .select(currency):
            return Observable.concat([rateInteractor.get(base: currency.name).map(Mutation.rateLoaded), .just(.valueUpdated(currency.value))])
        case let .type(value):
            return .just(Mutation.valueUpdated(value))
        }
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.share().startWith(.select(currency: Currency(name: "EUR", value: 1.0)))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .rateLoaded(rate):
            newState.rates = rate.rates
            newState.currencies = [Currency(name: rate.base, value: newState.value)]
                + newState.rates.filter { $0.key != rate.base }.map { Currency(name: $0.key, value: $0.value * newState.value) }
        case let .valueUpdated(value):
            newState.value = value
            newState.currencies = [Currency(name: newState.currencies[0].name, value: value)]
                + state.currencies[1..<state.currencies.count].map { Currency(name: $0.name, value: newState.rates[$0.name]! * value) }
        }
        
        return newState
    }
}
