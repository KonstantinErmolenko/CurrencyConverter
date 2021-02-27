//
//  String+Ext.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 25.02.2021.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
}
