//
//  KeyboardButton.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 17.02.2021.
//

import UIKit

protocol KeyboardDigitButtonDelegate: AnyObject {
    func addDigit(digit: String)
}

protocol KeyboardActionButtonDelegate: AnyObject {
    func addComma()
    func deleteSymbol()
}

class KeyboardButton: UIButton {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.secondaryBackground
        layer.cornerRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        setTitleColor(Colors.mainText, for: .normal)
    }
}

class KeyboardDigitButton: KeyboardButton {
    
    let delegate: KeyboardDigitButtonDelegate
    
    private let digit: String
    
    init(digit: String, delegate: KeyboardDigitButtonDelegate) {
        self.digit = digit
        self.delegate = delegate
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        accessibilityIdentifier = "digitButton\(digit)"
        setupLabel()
        addTarget(self, action: #selector(digitButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupLabel() {
        setTitle("\(digit)", for: .normal)
    }

    @objc private func digitButtonTapped(_ sender: KeyboardDigitButton) {
        delegate.addDigit(digit: sender.digit)
    }
}

class KeyboardActionButton: KeyboardButton {
    
    let delegate: KeyboardActionButtonDelegate
    
    private let action: KeyboardAction
    
    init(action: KeyboardAction, delegate: KeyboardActionButtonDelegate) {
        self.action = action
        self.delegate = delegate
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        switch action {
        case .delete:
            accessibilityIdentifier = "deleteButton"
            setupDeleteButtonImage()
        case .comma:
            accessibilityIdentifier = "commaButton"
            setupLabel()
        }
        addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func actionButtonTapped(_ sender: KeyboardActionButton) {
        switch sender.action {
        case .comma:
            delegate.addComma()
        case .delete:
            delegate.deleteSymbol()
        }
    }
    
    private func setupDeleteButtonImage() {
        let image = UIImage(systemName: "delete.left")!
        self.setImage(image, for: .normal)
        imageView?.tintColor = Colors.accentColor
        imageView?.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: 26)
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
    }
    
    private func setupLabel() {
        setTitle(",", for: .normal)
    }
}

enum KeyboardAction {
    case delete
    case comma
}
