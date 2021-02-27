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

    private var inputHandler = InputHandler()
    private var converter = Converter()
    
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
        view.backgroundColor = Colors.mainBackground
        
        configureCurrencyButtons()
        accessoryPanel = AccessoryPanel()
        accessoryPanel.delegate = self
        keyboard = Keyboard(delegate: self)
        
        configureAutoLayout()
    }
    
    private func configureCurrencyButtons() {
        let currencies = restoreCurrencies()
        
        currencyFromButton = CurrencyButton(currency: currencies.currencyFrom, delegate: self)
        currencyFromButton.accessibilityIdentifier = "currencyFrom"
        currencyToButton = CurrencyButton(currency: currencies.currencyTo, delegate: self)
        currencyToButton.accessibilityIdentifier = "currencyTo"
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
        setCurrencyRate()
        currencyFromButton.setValue(value: currencyFromValue)
        currencyToButton.setValue(value: currencyToValue)
    }
    
    private func restoreCurrencies() ->(currencyFrom: Currency, currencyTo: Currency){
        return (currencyFrom: Currencies.eur, currencyTo: Currencies.rub)
    }
    
    private func setCurrencyRate() {
        currencyFromButton.startUpdatingRate()
        currencyToButton.startUpdatingRate()
        
        let exchange = CurrencyExchange(from: currencyFromButton.currency,
                                        for: currencyToButton.currency)
        
        NetworkManager.shared.fetchCurrencyRate(exchange: exchange) { exchange, rate in
            guard exchange.fromCurrency.id == self.currencyFromButton.currency.id else { return }
            self.currencyRate = rate
            self.currencyFromButton.setRate(rate: self.currencyRate,
                                            toCurrency: exchange.forCurrency)
            self.currencyToButton.setRate(rate: 1.0/self.currencyRate,
                                          toCurrency: exchange.fromCurrency)            
            self.convertEnteredValue()
        }
    }
    
    private func convertEnteredValue() {
        let numberValue = inputHandler.convertToNumber(string: currencyFromValue,
                                                       maximumFractionDigits: 10)
        let convertedValue = converter.convert(amount: numberValue, byRate: currencyRate)
        
        let fractionDigits = currencyToButton.currency.fractionDigits
        currencyToValue = inputHandler.convertToString(number: convertedValue,
                                                       maximumFractionDigits: fractionDigits)
        currencyToButton.setValue(value: currencyToValue)
    }
}

// MARK: - KeyboardDelegate

extension ConverterViewController: KeyboardDelegate {
    func addDigit(digit: String) {
        let newValue = inputHandler.addDigit(
            digit: digit,
            to: currencyFromValue,
            maximumFractionDigits: currencyFromButton.currency.fractionDigits)
        currencyFromValue = inputHandler.format(string: newValue)
        currencyFromButton.setValue(value: currencyFromValue)
        convertEnteredValue()
    }
    
    func addComma() {
        currencyFromValue = inputHandler.addComma(to: currencyFromValue)
        currencyFromButton.setValue(value: currencyFromValue)
    }
    
    func deleteSymbol() {
        let newValue = inputHandler.deleteSymbol(from: currencyFromValue)
        currencyFromValue = inputHandler.format(string: newValue)
        currencyFromButton.setValue(value: currencyFromValue)
        convertEnteredValue()
    }
}

// MARK: - CurrencyButtonDelegate

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

// MARK: - CurrenciesListDelegate

extension  ConverterViewController: CurrenciesListDelegate {
    func changeCurrency(oldCurrency: Currency, newCurrency: Currency) {
        guard let changedButton = getCurrencyButtonWithId(==, id: oldCurrency.id) else { return }
        guard let anotherButton = getCurrencyButtonWithId(!=, id: oldCurrency.id) else { return }
        
        if newCurrency.id == anotherButton.currency.id {
            swapCurrencies()
        } else {
            changedButton.setCurrency(currency: newCurrency)
        }
        setCurrencyRate()
    }
    
    func getCurrencyButtonWithId(_ sign: (String?, String?) -> Bool, id: String) -> CurrencyButton? {
        let buttons = [currencyFromButton!, currencyToButton!]
        let result = buttons.filter { sign($0.currency.id, id) }.first
     
        return result
    }
}

// MARK: - AccessoryPanelDelegate

extension ConverterViewController: AccessoryPanelDelegate {
    func swapCurrencies() {
        let currencyFrom = currencyFromButton.currency
        let currencyTo = currencyToButton.currency
        
        currencyFromButton.setCurrency(currency: currencyTo)
        currencyToButton.setCurrency(currency: currencyFrom)
        setCurrencyRate()
    }

    func previousCurrency() {
        let current = currencyFromButton.currency
        guard let currentIndex = Currencies.all.firstIndex(where: { $0.id == current.id }) else {
            return
        }

        var previous = getPreviousCurrency(forIndex: currentIndex)
        if previous.currency.id == currencyToButton.currency.id {
            previous = getPreviousCurrency(forIndex: previous.index)
        }
        currencyFromButton.setCurrency(currency: previous.currency)
        setCurrencyRate()
    }
    
    func nextCurrency() {
        let current = currencyFromButton.currency
        guard let currentIndex = Currencies.all.firstIndex(where: { $0.id == current.id }) else {
            return
        }

        var next = getNextCurrency(forIndex: currentIndex)
        if next.currency.id == currencyToButton.currency.id {
            next = getNextCurrency(forIndex: next.index)
        }
        currencyFromButton.setCurrency(currency: next.currency)
        setCurrencyRate()
    }
    
    private func getPreviousCurrency(forIndex index: Int) -> (currency: Currency, index: Int) {
        var previousIndex = index - 1
        if previousIndex <= 0 {
            previousIndex = Currencies.all.count - 1
        }
        return (currency: Currencies.all[previousIndex], index: previousIndex)
    }
    
    private func getNextCurrency(forIndex index: Int) -> (currency: Currency, index: Int) {
        var nextIndex = index + 1
        if nextIndex > Currencies.all.count - 1 {
            nextIndex = 0
        }
        return (currency: Currencies.all[nextIndex], index: nextIndex)
    }
}
