//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
    private var currencyFromButton: CurrencyButton!
    private var currencyToButton: CurrencyButton!
    private var accessoryPanel: AccessoryPanel!
    private var keyboard: Keyboard!
    private var inputHandler: InputHandler!
    private var currencyFromValue = "0"
    private var currencyToValue = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setInitialValues()
    }
    
    private func configure() {
        title = "Converter"
        view.backgroundColor = Colors.swatch3
        layoutElements()
        inputHandler = InputHandler()
    }
    
    private func layoutElements() {
        currencyFromButton = CurrencyButton(currency: Currencies.eur)
        currencyFromButton.accessibilityIdentifier = "currencyFrom"
        view.addSubview(currencyFromButton)
        
        currencyToButton = CurrencyButton(currency: Currencies.rub)
        currencyToButton.accessibilityIdentifier = "currencyTo"
        view.addSubview(currencyToButton)
        
        accessoryPanel = AccessoryPanel()
        view.addSubview(accessoryPanel)

        keyboard = Keyboard(delegate: self)
        view.addSubview(keyboard)

        let padding: CGFloat = 10
        let safeArea = view.safeAreaLayoutGuide
        let constraints = [
            currencyFromButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            currencyFromButton.heightAnchor.constraint(equalTo: currencyToButton.heightAnchor),
            currencyFromButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            currencyFromButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            currencyToButton.topAnchor.constraint(equalTo: currencyFromButton.bottomAnchor, constant: padding),
            currencyToButton.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor),
            currencyToButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            currencyToButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            accessoryPanel.topAnchor.constraint(equalTo: currencyToButton.bottomAnchor, constant: padding),
            accessoryPanel.heightAnchor.constraint(equalTo: keyboard.heightAnchor, multiplier: 0.25),
            accessoryPanel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            accessoryPanel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            keyboard.topAnchor.constraint(equalTo: accessoryPanel.bottomAnchor, constant: padding),
            keyboard.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            keyboard.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            keyboard.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setInitialValues() {
        currencyFromButton.setValue(value: currencyFromValue)
        currencyToButton.setValue(value: currencyToValue)
    }
}

extension ConverterViewController: KeyboardDelegate {
    
    func addDigit(digit: String) {
        currencyFromValue = inputHandler.addDigit(digit: digit, to: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
    }
    
    func addComma() {
        currencyFromValue = inputHandler.addComma(to: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
    }
    
    func deleteSymbol() {
        currencyFromValue = inputHandler.deleteSymbol(from: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
    }
}
