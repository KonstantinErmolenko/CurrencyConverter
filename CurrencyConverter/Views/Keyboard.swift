//
//  Keyboard.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class Keyboard: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accessibilityIdentifier = "keyboard"
        backgroundColor = .systemGreen
        translatesAutoresizingMaskIntoConstraints = false
    }
}
