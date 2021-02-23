//
//  CurrenciesListViewController.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 23.02.2021.
//

import UIKit

protocol CurrenciesListDelegate: AnyObject {
    func changeCurrency(oldCurrency: Currency, newCurrency: Currency)
}

class CurrenciesListViewController: UIViewController {
    var currency: Currency!
    weak var delegate: CurrenciesListDelegate?
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = Colors.swatch3
        navigationController?.navigationBar.tintColor = Colors.accentColor
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self, action: #selector(dissmissVC)
        )
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "Currencies"
    }
    
    @objc private func dissmissVC() {
        dismiss(animated: true, completion: nil)
    }

    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Colors.swatch3
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseId)

        view.addSubview(tableView)
      }
}

extension CurrenciesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currencies.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseId) as! CurrencyCell
        
        let currencyForRow = Currencies.all[indexPath.row]
        let isSelected = currencyForRow.id == currency.id
        cell.set(currency: currencyForRow, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = Currencies.all[indexPath.row]
        guard selectedCurrency.id != currency.id else { return }
        delegate?.changeCurrency(oldCurrency: currency, newCurrency: selectedCurrency)
        dissmissVC()
    }
}
