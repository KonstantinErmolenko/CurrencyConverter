//
//  AccessoryPanel.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class AccessoryPanel: UIView {
    
    private var stackView: UIStackView!

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accessibilityIdentifier = "accessoryPanel"
        backgroundColor = Colors.swatch3
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.addArrangedSubview(AccessoryButton(action: .previous))
        stackView.addArrangedSubview(AccessoryButton(action: .swap))
        stackView.addArrangedSubview(AccessoryButton(action: .next))
        stackView.pinToEdges(of: self)
    }
}
