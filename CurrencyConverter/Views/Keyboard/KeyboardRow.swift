//
//  KeyboardRow.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 17.02.2021.
//

import UIKit

class KeyboardRow: UIStackView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = Colors.mainBackground
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 2
        axis = .horizontal
        distribution = .fillEqually        
    }
}
