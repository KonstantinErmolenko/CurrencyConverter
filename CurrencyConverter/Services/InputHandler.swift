//
//  InputHandler.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 22.02.2021.
//

import Foundation

final class InputHandler {
    let numberFormatter = NumberFormatter()
    
    init() {
        configureFormatter()
    }
    
    func addDigit(digit: String, to number: String, maximumFractionDigits: Int) -> String {
        if number == "0" {
            return digit
        }
        
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        let result = "\(number.removeSpaces())\(digit)"
        
        guard let nsNumber = numberFormatter.number(from: result),
              let resultString = numberFormatter.string(from: nsNumber) else {
            return "0"
        }
        
        return resultString
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

    func convertToString(number: Double, maximumFractionDigits: Int = 2) -> String {
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) ?? "0"
        return formattedNumber
    }
    
    func convertToNumber(string: String, maximumFractionDigits: Int = 2) -> Double {
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        let number = numberFormatter.number(from: string.removeSpaces()) ?? NSNumber(0.0)
        return number.doubleValue
    }

    func format(string: String) -> String {
        guard let nsNumber = numberFormatter.number(from: string.removeSpaces()),
              let resultString = numberFormatter.string(from: nsNumber) else {
            return "0"
        }
        return resultString
    }
    
    private func configureFormatter() {
        numberFormatter.decimalSeparator = ","
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
    }
}
