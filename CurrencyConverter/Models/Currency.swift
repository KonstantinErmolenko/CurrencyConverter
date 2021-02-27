//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 19.02.2021.
//

import UIKit

struct Currency {
    let id: String
    let name: String
    let fractionDigits: Int
    let sign: String
    
    func signImage() -> UIImage? {
        return UIImage(systemName: sign, withConfiguration: SfConfiguration.light)
    }
}

enum Currencies {
    static let eur = Currency(id: "EUR", name: "Euro", fractionDigits: 2, sign: "eurosign.circle")
    static let rub = Currency(id: "RUB", name: "Russian rouble", fractionDigits: 2, sign: "rublesign.circle")
               
    static let all = [
        Currency(id: "USD", name: "US dollar", fractionDigits: 2, sign: "dollarsign.circle"),
        Currency(id: "EUR", name: "Euro", fractionDigits: 2, sign: "eurosign.circle"),
        Currency(id: "RUB", name: "Russian rouble", fractionDigits: 2, sign: "rublesign.circle"),
        Currency(id: "AUD", name: "Australian dollar", fractionDigits: 2, sign: "dollarsign.circle"),
        Currency(id: "NZD", name: "New Zealand dollar", fractionDigits: 2, sign: "dollarsign.circle"),
        Currency(id: "JPY", name: "Japanese yen", fractionDigits: 3, sign: "yensign.circle"),
        Currency(id: "CNY", name: "Chinese yuan renminbi", fractionDigits: 2, sign: "yensign.circle"),
        Currency(id: "GBP", name: "Pound sterling", fractionDigits: 2, sign: "sterlingsign.circle"),
        Currency(id: "CHF", name: "Swiss franc", fractionDigits: 2, sign: "francsign.circle"),
        Currency(id: "TRY", name: "Turkish lira", fractionDigits: 2, sign: "turkishlirasign.circle"),
        Currency(id: "IDR", name: "Indonesian rupiah", fractionDigits: 2, sign: "indianrupeesign.circle"),
        Currency(id: "MXN", name: "Mexican peso", fractionDigits: 2, sign: "pesosign.circle"),
        Currency(id: "KRW", name: "South Korean won", fractionDigits: 2, sign: "wonsign.circle"),
    ]
}
