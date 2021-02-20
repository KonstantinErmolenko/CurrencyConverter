//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var currencyFromButton: CurrencyButton!
    var currencyToButton: CurrencyButton!
    var accessoryPanel: AccessoryPanel!
    var keyboard: Keyboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setValue()
    }
    
    private func configure() {
        title = "Converter"
        view.backgroundColor = Colors.swatch3
        layoutElements()
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

        keyboard = Keyboard()
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

    private func setValue() {
        currencyFromButton.setValue(value: "809")
        currencyToButton.setValue(value: "72662,03")
    }
}
