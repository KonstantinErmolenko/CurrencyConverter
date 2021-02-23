//
//  CurrencyButton.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 19.02.2021.
//

import UIKit

protocol CurrencyButtonDelegate: AnyObject {
    func buttonTapped(currency: Currency)
}

class CurrencyButton: UIButton {
    var currency: Currency
    weak var delegate: CurrencyButtonDelegate!
    
    private let signView: UIImageView!
    private let valueLabel: UILabel!
    private let arrowView: UIImageView!

    init(currency: Currency, delegate: CurrencyButtonDelegate) {
        self.currency = currency
        self.delegate = delegate
        
        signView = UIImageView(image: currency.signImage())
        valueLabel = UILabel()
        valueLabel.accessibilityIdentifier = "currencyValue"
        arrowView = UIImageView(image: UIImage(systemName: "chevron.down"))
        
        super.init(frame: .zero)
        
        configure(currency: currency)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrency(currency: Currency) {
        self.currency = currency
        signView.image = currency.signImage()
    }
    
    func setValue(value: String) {
        valueLabel.text = value
    }
    
    func setRate(rate: Double) {
        
    }
    
    private func configure(currency: Currency) {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        backgroundColor = Colors.swatch4
        signView.tintColor = Colors.swatch1
        valueLabel.textColor = Colors.swatch1
        arrowView.tintColor = Colors.accentColor

        signView.image = currency.signImage()
        signView.contentMode = .scaleAspectFit
        
        valueLabel.font = UIFont.systemFont(ofSize: 42, weight: .medium)
    }

    private func layoutElements() {
        addSubviews(signView, valueLabel, arrowView)

        signView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 16
        let constraints = [
            signView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signView.heightAnchor.constraint(equalToConstant: 55),
            signView.widthAnchor.constraint(equalTo: signView.heightAnchor),
            signView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 60),
            valueLabel.leadingAnchor.constraint(equalTo: signView.trailingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -padding),
            
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowView.heightAnchor.constraint(equalToConstant: 26),
            arrowView.widthAnchor.constraint(equalTo: arrowView.heightAnchor),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func buttonTapped(){
        delegate.buttonTapped(currency: currency)
    }
}
