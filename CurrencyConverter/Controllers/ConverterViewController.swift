//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var firstCurrency: UIButton!
    var secondCurrency: UIButton!
    var accessoryPanel: AccessoryPanel!
    var keyboard: Keyboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        title = "Converter"
        view.backgroundColor = Colors.swatch3
        layoutElements()
    }
    
    func layoutElements() {
        firstCurrency = UIButton()
        firstCurrency.backgroundColor = Colors.swatch4
        firstCurrency.translatesAutoresizingMaskIntoConstraints = false
        firstCurrency.accessibilityIdentifier = "firstCurrency"
        firstCurrency.setTitle("USD", for: .normal)
        firstCurrency.setTitleColor(Colors.swatch1, for: .normal)
        view.addSubview(firstCurrency)
        
        secondCurrency = UIButton()
        secondCurrency.backgroundColor = Colors.swatch4
        secondCurrency.translatesAutoresizingMaskIntoConstraints = false
        secondCurrency.accessibilityIdentifier = "secondCurrency"
        secondCurrency.setTitle("RUB", for: .normal)
        secondCurrency.setTitleColor(Colors.swatch1, for: .normal)
        view.addSubview(secondCurrency)
        
        accessoryPanel = AccessoryPanel()
        view.addSubview(accessoryPanel)

        keyboard = Keyboard()
        view.addSubview(keyboard)

        let padding: CGFloat = 10
        let safeArea = view.safeAreaLayoutGuide
        let constraints = [
            firstCurrency.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            firstCurrency.heightAnchor.constraint(equalTo: secondCurrency.heightAnchor),
            firstCurrency.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            firstCurrency.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            secondCurrency.topAnchor.constraint(equalTo: firstCurrency.bottomAnchor, constant: padding),
            secondCurrency.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor),
            secondCurrency.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            secondCurrency.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            accessoryPanel.topAnchor.constraint(equalTo: secondCurrency.bottomAnchor, constant: padding),
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
}
