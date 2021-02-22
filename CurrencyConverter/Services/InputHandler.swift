//
//  InputHandler.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 22.02.2021.
//

import Foundation

final class InputHandler {
    
    let formatter = NumberFormatter()
    
    init() {
        configureFormatter()
    }
    
    func addDigit(digit: String, to number: String) -> String {
        if number == "0" {
            return digit
        } else {
            return "\(number)\(digit)"
        }
    }

    func addComma(to number: String) -> String {
        if !number.contains(",") {
            return "\(number),"
        }
        return number
    }
    
    func deleteSymbol(from number: String) -> String {
        if number.count == 1 {
            return "0"
        } else {
            return String(number.dropLast())
        }
    }

    func formatValue(_ value: Double) -> String {
        let formattedNumber = formatter.string(from: NSNumber(value: value)) ?? "0"
        return formattedNumber
    }
    
    private func configureFormatter() {
        formatter.decimalSeparator = ","
        formatter.numberStyle = .decimal

    }
}
