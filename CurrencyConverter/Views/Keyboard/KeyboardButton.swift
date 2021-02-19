//
//  KeyboardButton.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 17.02.2021.
//

import UIKit

class KeyboardButton: UIButton {

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.swatch4
        layer.cornerRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .light)
        setTitleColor(Colors.swatch1, for: .normal)
    }
}

class KeyboardNumberButton: KeyboardButton {
    
    private let number: Int
    
    init(number: Int) {
        self.number = number
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        accessibilityIdentifier = "numberButton\(number)"
        setupLabel()
    }
    
    private func setupLabel() {
        setTitle("\(number)", for: .normal)
    }
}

class KeyboardActionButton: KeyboardButton {
    
    let action: KeyboardAction
    
    init(action: KeyboardAction) {
        self.action = action
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        switch action {
        case .delete:
            accessibilityIdentifier = "deleteButton"
            setupImage()
        case .comma:
            accessibilityIdentifier = "commaButton"
            setupLabel()
        }
    }
    
    private func setupImage() {
        let image: UIImage
        switch action {
        case .delete:
            image = UIImage(systemName: "arrow.uturn.backward")!
        case .comma:
            image = UIImage(systemName: "number.circle.fill")!
        }
        
        self.setImage(image, for: .normal)
        imageView?.tintColor = Colors.accentColor
        imageView?.contentMode = .scaleAspectFit
        
        let config = UIImage.SymbolConfiguration(pointSize: 35)
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
    }
    
    private func setupLabel() {
        setTitle(",", for: .normal)
    }
}

enum KeyboardAction {
    case delete
    case comma

}
