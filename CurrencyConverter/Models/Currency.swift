//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 19.02.2021.
//

import UIKit

struct Currency {
    let ID: String
    let name: String
    let sign: String
    
    func signImage() -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(weight: .light)
        return UIImage(systemName: sign, withConfiguration: configuration)
    }
}

enum Currencies {
    static let eur = Currency(ID: "EUR", name: "Euro", sign: "eurosign.circle")
    static let rub = Currency(ID: "RUB", name: "Russian rouble", sign: "rublesign.circle")
               
    static let all = [
        Currency(ID: "USD", name: "US dollar", sign: "dollarsign.circle"),
        Currency(ID: "EUR", name: "Euro", sign: "eurosign.circle"),
        Currency(ID: "RUB", name: "Russian rouble", sign: "rublesign.circle"),
        Currency(ID: "AUD", name: "Australian dollar", sign: "dollarsign.circle"),
        Currency(ID: "NZD", name: "New Zealand dollar", sign: "dollarsign.circle"),
        Currency(ID: "JPY", name: "Japanese yen", sign: "yensign.circle"),
        Currency(ID: "CNY", name: "Chinese yuan renminbi", sign: "yensign.circle"),
        Currency(ID: "GBP", name: "Pound sterling", sign: "sterlingsign.circle"),
        Currency(ID: "CHF", name: "Swiss franc", sign: "francsign.circle"),
        Currency(ID: "TRY", name: "Turkish lira", sign: "turkishlirasign.circle"),
        Currency(ID: "IDR", name: "Indonesian rupiah", sign: "indianrupeesign.circle"),
        Currency(ID: "MXN", name: "Mexican peso", sign: "pesosign.circle"),
        Currency(ID: "KRW", name: "South Korean won", sign: "wonsign.circle"),
    ]
}
