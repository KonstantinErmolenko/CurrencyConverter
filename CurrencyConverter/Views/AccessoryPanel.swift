//
//  AccessoryPanel.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class AccessoryPanel: UIView {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accessibilityIdentifier = "accessoryPanel"
        backgroundColor = .systemGray
        translatesAutoresizingMaskIntoConstraints = false
    }
}
