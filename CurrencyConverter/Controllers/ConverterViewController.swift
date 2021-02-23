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
    private var converter: Converter!
    
    private var currencyFromValue = "0"
    private var currencyToValue = "0"
    private var currencyRate = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setInitialValues()
    }
    
    private func configure() {
        title = "Converter"
        view.backgroundColor = Colors.swatch3
        
        currencyFromButton = CurrencyButton(currency: Currencies.eur, delegate: self)
        currencyFromButton.accessibilityIdentifier = "currencyFrom"
        currencyToButton = CurrencyButton(currency: Currencies.rub, delegate: self)
        currencyToButton.accessibilityIdentifier = "currencyTo"
        accessoryPanel = AccessoryPanel()
        keyboard = Keyboard(delegate: self)
        
        configureAutoLayout()
        
        inputHandler = InputHandler()
        converter = Converter()
    }
    
    private func configureAutoLayout() {
        view.addSubviews(currencyFromButton, currencyToButton, accessoryPanel, keyboard)
        
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
        currencyRate = 90.98
        currencyFromButton.setValue(value: currencyFromValue)
        currencyToButton.setValue(value: currencyToValue)
    }
    
    private func calculateCurrencyToValue() {
        let numberValue = inputHandler.convertToNumber(string: currencyFromValue)
        let convertedValue = converter.convert(amount: numberValue, byRate: currencyRate)
        currencyToValue = inputHandler.convertToString(number: convertedValue)
        currencyToButton.setValue(value: currencyToValue)
    }
    
    private func swapCurrencies() {
        let currencyFrom = currencyFromButton.currency
        let currencyTo = currencyToButton.currency
        
        currencyFromButton.setCurrency(currency: currencyTo)
        currencyToButton.setCurrency(currency: currencyFrom)
    }
}

extension ConverterViewController: KeyboardDelegate {
    func addDigit(digit: String) {
        currencyFromValue = inputHandler.addDigit(digit: digit, to: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
        calculateCurrencyToValue()
    }
    
    func addComma() {
        currencyFromValue = inputHandler.addComma(to: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
    }
    
    func deleteSymbol() {
        currencyFromValue = inputHandler.deleteSymbol(from: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
        calculateCurrencyToValue()
    }
}

extension ConverterViewController: CurrencyButtonDelegate {  
    func buttonTapped(currency: Currency) {
        let listVC = CurrenciesListViewController()
        listVC.delegate = self
        listVC.currency = currency
        
        let navController = UINavigationController(rootViewController: listVC)
        navController.modalPresentationStyle = .popover
        present(navController, animated: true, completion: nil)
    }
}

extension  ConverterViewController: CurrenciesListDelegate {
    func changeCurrency(oldCurrency: Currency, newCurrency: Currency) {
        let changedButton = currencyButtonById(id: oldCurrency.id)
        let anotherButton = anotherCurrencyButton(id: oldCurrency.id)
        
        if newCurrency.id == anotherButton.currency.id {
            swapCurrencies()
        } else {
            changedButton.setCurrency(currency: newCurrency)
        }
    }
    
    func currencyButtonById(id: String) -> CurrencyButton {
        if currencyFromButton.currency.id == id {
            return currencyFromButton
        } else {
            return currencyToButton
        }
    }
    
    func anotherCurrencyButton(id: String) -> CurrencyButton {
        if currencyFromButton.currency.id != id {
            return currencyFromButton
        } else {
            return currencyToButton
        }
    }
}
