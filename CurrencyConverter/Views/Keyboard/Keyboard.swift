//
//  Keyboard.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class Keyboard: UIView {
    
    private var stackView: UIStackView!

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accessibilityIdentifier = "keyboard"
        backgroundColor = Colors.swatch3
        translatesAutoresizingMaskIntoConstraints = false
        layoutElements()
    }
    
    func layoutElements() {
        stackView = UIStackView()
        stackView.backgroundColor = Colors.swatch3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        let row1 = KeyboardRow()
        for number in 1...3 {
            row1.addArrangedSubview(KeyboardNumberButton(number: number))
        }
        stackView.addArrangedSubview(row1)
        
        let row2 = KeyboardRow()
        for number in 4...6 {
            row2.addArrangedSubview(KeyboardNumberButton(number: number))
        }
        stackView.addArrangedSubview(row2)

        let row3 = KeyboardRow()
        for number in 7...9 {
            row3.addArrangedSubview(KeyboardNumberButton(number: number))
        }
        stackView.addArrangedSubview(row3)

        let row4 = KeyboardRow()
        row4.addArrangedSubview(KeyboardActionButton(action: .comma))
        row4.addArrangedSubview(KeyboardNumberButton(number: 0))
        row4.addArrangedSubview(KeyboardActionButton(action: .delete))
        stackView.addArrangedSubview(row4)

        stackView.pinToEdges(of: self)
    }
}
