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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        title = "Converter"
        view.backgroundColor = .systemBackground
        layoutElements()
    }
    
    func layoutElements() {
        firstCurrency = UIButton()
        firstCurrency.backgroundColor = .systemPink
        firstCurrency.translatesAutoresizingMaskIntoConstraints = false
        firstCurrency.accessibilityIdentifier = "firstCurrency"
        firstCurrency.setTitle("USD", for: .normal)
        
        secondCurrency = UIButton()
        secondCurrency.backgroundColor = .systemTeal
        secondCurrency.translatesAutoresizingMaskIntoConstraints = false
        secondCurrency.accessibilityIdentifier = "secondCurrency"
        secondCurrency.setTitle("RUB", for: .normal)

        view.addSubview(firstCurrency)
        view.addSubview(secondCurrency)

        firstCurrency.backgroundColor = .systemTeal
        secondCurrency.backgroundColor = .systemPink
        
        let padding: CGFloat = 10
        let safeArea = view.safeAreaLayoutGuide
        let constraints = [
            firstCurrency.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            firstCurrency.heightAnchor.constraint(equalToConstant: 100),
            firstCurrency.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            firstCurrency.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            
            secondCurrency.topAnchor.constraint(equalTo: firstCurrency.bottomAnchor, constant: padding),
            secondCurrency.heightAnchor.constraint(equalToConstant: 100),
            secondCurrency.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            secondCurrency.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
