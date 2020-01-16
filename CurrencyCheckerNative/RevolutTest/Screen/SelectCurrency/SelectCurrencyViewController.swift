//
//  SelectCurrencyViewController.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class SelectCurrencyViewController: UIViewController, StoryboardInstantiatable {
    var viewModel: SelectCurrencyViewModel!
    var onSelectCurrency: ((Currency) -> Void)?
    @IBOutlet private var tableView: UITableView!
    private let reuseIdentifier = String(describing: CurrencyTableViewCell.self)
    private var currencyCellDtos = [CurrencyCellDto]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(nibName: String(describing: CurrencyTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: reuseIdentifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currencyCellDtos = viewModel.getCurrencies()
    }
}

// MARK: - UITableViewDataSource
extension SelectCurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyCellDtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CurrencyTableViewCell else {
            fatalError("TableView setup is incorrect")
        }
        let currencyCellDto = currencyCellDtos[indexPath.row]
        cell.isUserInteractionEnabled = currencyCellDto.isEnabled
        cell.configure(currencyCellDto: currencyCellDto)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectCurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencyCellDtos[indexPath.row]
        onSelectCurrency?(currency.currency)
    }
}
