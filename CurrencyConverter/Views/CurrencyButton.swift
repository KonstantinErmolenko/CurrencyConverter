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
    private let nameLabel = UILabel()
    private let arrowView = UIImageView(image: UIImage(systemName: "chevron.down"))
    
    private var activityIndicator: UIActivityIndicatorView!

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
        nameLabel.text = currency.name
        signView.image = currency.signImage()
    }
    
    func setValue(value: String) {
        DispatchQueue.main.async {
            self.valueLabel.text = value
        }
    }
    
    func setRate(rate: Double, toCurrency: Currency) {
        DispatchQueue.main.async {
            self.deactivateActivityIndicator()
            self.rateLabel.isHidden = false
            let rateFormatted = rate.string(maximumFractionDigits: 4)
            self.rateLabel.text = "1 \(self.currency.id) = \(rateFormatted) \(toCurrency.id)"
        }
    }
    
    private func deactivateActivityIndicator() {
        if self.activityIndicator != nil {
            self.activityIndicator.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
    
    func startUpdatingRate() {
        guard activityIndicator == nil || !activityIndicator.isAnimating else { return }
        
        rateLabel.isHidden = true
        showActivityIndicator()
    }
    
    private func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        addSubview(activityIndicator)
        configureActivityIndicatorAutoLayout()
        activityIndicator.startAnimating()
    }
    
    private func configure(currency: Currency) {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        backgroundColor = Colors.secondaryBackground
        signView.tintColor = Colors.mainText
        valueLabel.textColor = Colors.mainText
        arrowView.tintColor = Colors.accentColor
        nameLabel.textColor = Colors.mainText
        rateLabel.textColor = Colors.secondaryText

        signView.image = currency.signImage()
        signView.contentMode = .scaleAspectFit

        arrowView.contentMode = .scaleAspectFit
        
        nameLabel.text = currency.name
        
        valueLabel.accessibilityIdentifier = "currencyValue"
        valueLabel.font = UIFont.systemFont(ofSize: 42, weight: .medium)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.4
        
        rateLabel.isHidden = true
    }

    private func configureAutoLayout() {
        let addedSubvies = [signView, nameLabel, valueLabel, arrowView, rateLabel]
        addSubviews(addedSubvies)

        for subview in addedSubvies {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureNameVerticalPositionRules()
        configureRateVerticalPositionRules()
        
        let padding: CGFloat = 6
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: signView.leadingAnchor, constant: 2*padding),
            nameLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            
            signView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            signView.widthAnchor.constraint(equalTo: signView.heightAnchor),
            signView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.heightAnchor.constraint(equalTo: signView.heightAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: signView.trailingAnchor, constant: 2*padding),
            valueLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -1.5*padding),
            
            rateLabel.leadingAnchor.constraint(equalTo: signView.leadingAnchor, constant: 2*padding),
            rateLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            arrowView.widthAnchor.constraint(equalTo: arrowView.heightAnchor),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.5*padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureNameVerticalPositionRules() {
        let dimensionBefore = nameLabel.centerYAnchor.anchorWithOffset(to: topAnchor)
        let dimensionAfter = signView.topAnchor.anchorWithOffset(to: nameLabel.centerYAnchor)
        dimensionBefore.constraint(equalTo: dimensionAfter, multiplier: 1).isActive = true
    }

    private func configureRateVerticalPositionRules() {
        let dimensionBefore = signView.bottomAnchor.anchorWithOffset(to: rateLabel.centerYAnchor)
        let dimensionAfter = rateLabel.centerYAnchor.anchorWithOffset(to: bottomAnchor)
        dimensionBefore.constraint(equalTo: dimensionAfter, multiplier: 1).isActive = true
    }
    
    private func configureActivityIndicatorAutoLayout() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: signView.leadingAnchor, constant: 12).isActive = true
        
        let dimensionBefore = signView.bottomAnchor.anchorWithOffset(to: activityIndicator.centerYAnchor)
        let dimensionAfter = activityIndicator.centerYAnchor.anchorWithOffset(to: bottomAnchor)
        dimensionBefore.constraint(equalTo: dimensionAfter, multiplier: 1).isActive = true
    }
    
    @objc private func buttonTapped() {
        delegate.buttonTapped(currency: currency)
    }
}
