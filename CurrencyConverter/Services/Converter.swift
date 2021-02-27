//
//  Converter.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 23.02.2021.
//

import Foundation

final class Converter {    
    func convert(amount: Double, byRate rate: Double) -> Double {
        return amount * rate
    }
}
