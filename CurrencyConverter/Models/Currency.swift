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
    let sign: String
    
    func signImage() -> UIImage? {
        return UIImage(systemName: sign, withConfiguration: SfConfiguration.light)
    }
}

enum Currencies {
    static let eur = Currency(id: "EUR", name: "Euro", sign: "eurosign.circle")
    static let rub = Currency(id: "RUB", name: "Russian rouble", sign: "rublesign.circle")
               
    static let all = [
        Currency(id: "USD", name: "US dollar", sign: "dollarsign.circle"),
        Currency(id: "EUR", name: "Euro", sign: "eurosign.circle"),
        Currency(id: "RUB", name: "Russian rouble", sign: "rublesign.circle"),
        Currency(id: "AUD", name: "Australian dollar", sign: "dollarsign.circle"),
        Currency(id: "NZD", name: "New Zealand dollar", sign: "dollarsign.circle"),
        Currency(id: "JPY", name: "Japanese yen", sign: "yensign.circle"),
        Currency(id: "CNY", name: "Chinese yuan renminbi", sign: "yensign.circle"),
        Currency(id: "GBP", name: "Pound sterling", sign: "sterlingsign.circle"),
        Currency(id: "CHF", name: "Swiss franc", sign: "francsign.circle"),
        Currency(id: "TRY", name: "Turkish lira", sign: "turkishlirasign.circle"),
        Currency(id: "IDR", name: "Indonesian rupiah", sign: "indianrupeesign.circle"),
        Currency(id: "MXN", name: "Mexican peso", sign: "pesosign.circle"),
        Currency(id: "KRW", name: "South Korean won", sign: "wonsign.circle"),
    ]
}
