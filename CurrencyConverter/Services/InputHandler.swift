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
        
        guard numberOfFractionDigitsIsNotExceeded(
                number: number,
                maximumFractionDigits: maximumFractionDigits) else {
            return number
        }
        let result = "\(number.removeSpaces())\(digit)"
        
        numberFormatter.maximumFractionDigits = maximumFractionDigits
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

    func convertToString(number: Double, maximumFractionDigits: Int) -> String {
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) ?? "0"
        return formattedNumber
    }
    
    func convertToNumber(string: String, maximumFractionDigits: Int) -> Double {
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        let number = numberFormatter.number(from: string.removeSpaces()) ?? NSNumber(0.0)
        return number.doubleValue
    }

    func format(string: String, maximumFractionDigits: Int) -> String {
        numberFormatter.maximumFractionDigits = maximumFractionDigits
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
    
    private func numberOfFractionDigitsIsNotExceeded (number: String, maximumFractionDigits: Int) -> Bool {
        guard number.contains(",") else { return true }
        let splited = number.split(separator: ",")

        guard splited.count == 2 else { return true }
        let numberFractionDigits = splited.last?.count ?? 0

        return numberFractionDigits < maximumFractionDigits
    }
}
