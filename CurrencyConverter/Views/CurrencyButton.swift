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
    
    private let signView = UIImageView()
    private let valueLabel = UILabel()
    private let rateLabel = UILabel()
    private let arrowView = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    private var ai: UIActivityIndicatorView!

    init(currency: Currency, delegate: CurrencyButtonDelegate) {
        self.currency = currency
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        configure(currency: currency)
        configureAutoLayout()
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
        DispatchQueue.main.async {
            if self.ai != nil {
            self.ai.removeFromSuperview()
                self.ai = nil
            }
            self.rateLabel.isHidden = false
            self.rateLabel.text = "Rate: \(rate.string(maximumFractionDigits: 10))"
        }
    }
    
    func startUpdatingRate() {
        guard ai == nil || !ai.isAnimating else { return }
        
        rateLabel.isHidden = true
        
        ai = UIActivityIndicatorView()
        addSubview(ai)
        
        ai.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            ai.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ai.heightAnchor.constraint(equalToConstant: 30),
            ai.widthAnchor.constraint(equalTo: ai.heightAnchor),
            ai.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
        ]
        NSLayoutConstraint.activate(constraints)
        
        ai.startAnimating()
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

        valueLabel.accessibilityIdentifier = "currencyValue"
        valueLabel.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        
        rateLabel.isHidden = true
    }

    private func configureAutoLayout() {
        addSubviews(signView, valueLabel, arrowView, rateLabel)

        signView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 16
        let constraints = [
            rateLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            rateLabel.heightAnchor.constraint(equalToConstant: 30),
            rateLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            
            signView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            signView.heightAnchor.constraint(equalToConstant: 55),
            signView.widthAnchor.constraint(equalTo: signView.heightAnchor),
            signView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            valueLabel.heightAnchor.constraint(equalToConstant: 60),
            valueLabel.leadingAnchor.constraint(equalTo: signView.trailingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -padding),
            
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            arrowView.heightAnchor.constraint(equalToConstant: 26),
            arrowView.widthAnchor.constraint(equalTo: arrowView.heightAnchor),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func buttonTapped() {
        delegate.buttonTapped(currency: currency)
    }
}
