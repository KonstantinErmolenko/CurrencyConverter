//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 23.02.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    static let reuseId = "currencyCell"
    
    private var signView = UIImageView()
    private var nameLabel = UILabel()
    private var checkmarkView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(currency: Currency, isSelected: Bool) {
        signView.image = currency.signImage()
        nameLabel.text = currency.name
        checkmarkView.isHidden = !isSelected
        
        if isSelected {
            signView.tintColor = Colors.accentColor
        }
    }
    
    private func configue() {
        signView.tintColor = Colors.mainText
        checkmarkView.image = UIImage(systemName: "checkmark",
                                      withConfiguration: SfConfiguration.light)
        checkmarkView.tintColor = Colors.accentColor
        configureAutoLayout()
    }
    
    func configureAutoLayout() {
        addSubviews(signView, nameLabel, checkmarkView)
        
        signView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 16
        let constraints = [
            signView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            signView.widthAnchor.constraint(equalTo: signView.heightAnchor),
            signView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            nameLabel.leadingAnchor.constraint(equalTo: signView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -padding),
            
            checkmarkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45),
            checkmarkView.widthAnchor.constraint(equalTo: checkmarkView.heightAnchor),
            checkmarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
