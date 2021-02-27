//
//  AccessoryButton.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 18.02.2021.
//

import UIKit

protocol AccessoryButtonDelegate: AnyObject {
    func accessoryButtonTapped(action: AccessoryActions)
}

enum AccessoryActions {
    case previous
    case swap
    case next
}

class AccessoryButton: UIButton {

    let action: AccessoryActions
    weak var delegate: AccessoryButtonDelegate?
    
    init(action: AccessoryActions) {
        self.action = action
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.mainBackground
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupAccessibilityIdentifier()
        setupImage()
    }

    private func setupAccessibilityIdentifier() {
        switch action {
        case .previous:
            accessibilityIdentifier = "previousButton"
        case .swap:
            accessibilityIdentifier = "swapButton"
        case .next:
            accessibilityIdentifier = "nextButton"
        }
    }
    
    private func setupImage() {
        
        let image: UIImage
        
        switch action {
        case .previous:
            image = UIImage(systemName: "arrow.counterclockwise")!
        case .swap:
            image = UIImage(systemName: "arrow.triangle.2.circlepath")!
        case .next:
            image = UIImage(systemName: "arrow.clockwise")!
        }
        
        self.setImage(image, for: .normal)
        imageView?.tintColor = Colors.accentColor
        imageView?.contentMode = .scaleAspectFit
        
        let config = UIImage.SymbolConfiguration(pointSize: 35)
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
    }

    @objc private func buttonTapped() {
        delegate?.accessoryButtonTapped(action: action)
    }
}
