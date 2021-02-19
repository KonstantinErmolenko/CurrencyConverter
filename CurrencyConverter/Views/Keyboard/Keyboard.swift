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
        configureStackView()
        layoutElements()
    }
    
    private func layoutElements() {
        addSubview(stackView)
        stackView.pinToEdges(of: self)
    }

    private func configureStackView() {
        stackView = UIStackView()
        stackView.backgroundColor = Colors.swatch3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        let numbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        for numbersInRow in numbers {
            let row = KeyboardRow()
            for number in numbersInRow {
                row.addArrangedSubview(KeyboardNumberButton(number: number))
            }
            stackView.addArrangedSubview(row)
        }

        let row = KeyboardRow()
        row.addArrangedSubview(KeyboardActionButton(action: .comma))
        row.addArrangedSubview(KeyboardNumberButton(number: 0))
        row.addArrangedSubview(KeyboardActionButton(action: .delete))
        stackView.addArrangedSubview(row)
    }
}
