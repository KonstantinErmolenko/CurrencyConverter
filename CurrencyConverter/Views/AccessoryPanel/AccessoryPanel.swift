//
//  AccessoryPanel.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import UIKit

protocol AccessoryPanelDelegate: AnyObject {
    func swapCurrencies()
    func previousCurrency()
    func nextCurrency()
}

class AccessoryPanel: UIView {
    weak var delegate: AccessoryPanelDelegate?
    private var stackView: UIStackView!

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.mainBackground
        accessibilityIdentifier = "accessoryPanel"
        translatesAutoresizingMaskIntoConstraints = false
        
        configureStackView()
        configureAccessoryButtons()
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinToEdges(of: self)
    }
    
    private func configureAccessoryButtons() {
        let previousButton = AccessoryButton(action: .previous)
        previousButton.delegate = self
        stackView.addArrangedSubview(previousButton)
        
        let swapButton = AccessoryButton(action: .swap)
        swapButton.delegate = self
        stackView.addArrangedSubview(swapButton)
        
        let nextButton = AccessoryButton(action: .next)
        nextButton.delegate = self
        stackView.addArrangedSubview(nextButton)
    }
}

// MARK: - AccessoryButtonDelegate

extension AccessoryPanel: AccessoryButtonDelegate {
    func accessoryButtonTapped(action: AccessoryActions) {
        switch action {
        case .swap:
            delegate?.swapCurrencies()
        case .previous:
            delegate?.previousCurrency()
        case .next:
            delegate?.nextCurrency()
        }
    }
}
