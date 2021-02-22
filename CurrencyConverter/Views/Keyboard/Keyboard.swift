//
//  Keyboard.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

protocol KeyboardDelegate: AnyObject {
    func addDigit(digit: String)
    func addComma()
    func deleteSymbol()
}

class Keyboard: UIView {
    
    var delegate: KeyboardDelegate?
    
    private var stackView: UIStackView!

    init(delegate: KeyboardDelegate) {
        self.delegate = delegate
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
        configureKeyboard()
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
    }
    
    private func configureKeyboard() {
        let digits = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
        for digitsInRow in digits {
            let row = KeyboardRow()
            for digit in digitsInRow {
                row.addArrangedSubview(KeyboardDigitButton(digit: digit, delegate: self))
            }
            stackView.addArrangedSubview(row)
        }

        let row = KeyboardRow()
        row.addArrangedSubview(KeyboardActionButton(action: .comma, delegate: self))
        row.addArrangedSubview(KeyboardDigitButton(digit: "0", delegate: self))
        row.addArrangedSubview(KeyboardActionButton(action: .delete, delegate: self))
        stackView.addArrangedSubview(row)
    }
}

// MARK: - Keyboard buttons delegate

extension Keyboard: KeyboardDigitButtonDelegate, KeyboardActionButtonDelegate {
    
    func addDigit(digit: String) {
        delegate?.addDigit(digit: digit)
    }
    
    func addComma() {
        delegate?.addComma()
    }
    
    func deleteSymbol() {
        delegate?.deleteSymbol()
    }
}
