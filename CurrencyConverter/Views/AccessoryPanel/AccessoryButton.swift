//
//  AccessoryButton.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 18.02.2021.
//

import UIKit

class AccessoryButton: UIButton {

    let action: AccessoryActions
    
    init(action: AccessoryActions) {
        self.action = action
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.swatch3
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        
        switch action {
        case .previous:
            accessibilityIdentifier = "previousButton"
        case .swap:
            accessibilityIdentifier = "swapButton"
        case .next:
            accessibilityIdentifier = "nextButton"
        }
        setupImage()
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
}

enum AccessoryActions {
    case previous
    case swap
    case next
}
