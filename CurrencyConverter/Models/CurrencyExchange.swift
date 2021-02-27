//
//  CurrencyExchange.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 25.02.2021.
//

import Foundation

struct CurrencyExchange {
    let fromCurrency: Currency
    let forCurrency: Currency
    
    init(from fromCurrency: Currency, for forCurrency: Currency) {
        self.fromCurrency = fromCurrency
        self.forCurrency = forCurrency
    }
}
