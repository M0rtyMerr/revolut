//
//  PairsViewController.swift
//  RevolutTest
//
//  Created by Anton Nazarov on 26/03/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

final class PairsViewController: UIViewController, StoryboardInstantiatable {
    var pairsViewModel: PairsViewModel!
    var onAddPair: (() -> Void)?
    @IBOutlet private var tableView: UITableView!
    private let reuseIdentifier = String(describing: CurrencyPairTableViewCell.self)
    private lazy var emptyView = makeEmptyView()
    private lazy var headerView = makeHeaderView()
    private var currencyPairs = [CurrencyPair]() {
        didSet {
            DispatchQueue.main.async {
                guard oldValue.count == self.currencyPairs.count, !self.currencyPairs.isEmpty else {
                    self.updateEmptyHeaderView()
                    return
                }
                self.tableView.indexPathsForVisibleRows?.forEach {
                    guard let cell = self.tableView.cellForRow(at: $0) as? CurrencyPairTableViewCell,
                        let currencyPair = self.currencyPairs[safe: $0.row] else {
                            return
                    }
                    cell.configure(currencyPair: currencyPair)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(nibName: String(describing: CurrencyPairTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: reuseIdentifier
        )
        pairsViewModel.onChange = { [weak self] in
            self?.currencyPairs = $0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "Roboto-Medium", size: 16) as Any
        ]
        navigationController?.navigationBar.shadowImage = UIImage()
        pairsViewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pairsViewModel.viewWillDisappear()
    }
}

// MARK: - Private
private extension PairsViewController {
    func updateEmptyHeaderView() {
        self.tableView.tableHeaderView = self.currencyPairs.isEmpty ? nil : self.headerView
        UIView.animate(
            withDuration: 0.1,
            animations: { self.tableView.reloadSections([0], with: .fade)  },
            completion: { _ in
                self.tableView.backgroundView = self.currencyPairs.isEmpty ? self.emptyView : nil
            }
        )
    }
    
    func makeEmptyView() -> PairsEmptyView {
        let emptyView = PairsEmptyView.instantiate()
        emptyView.onAdd = { [weak self] in
            self?.onAddPair?()
        }
        return emptyView
    }
    
    func makeHeaderView() -> PairsHeaderView {
        let headerView = PairsHeaderView.instantiate()
        headerView.onAdd = { [weak self] in
            self?.onAddPair?()
        }
        return headerView
    }
}

// MARK: - UITableViewDataSource
extension PairsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyPairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CurrencyPairTableViewCell else {
            fatalError("TableView setup is incorrect")
        }
        cell.configure(currencyPair: currencyPairs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let currencyPair = currencyPairs[indexPath.row]
        pairsViewModel.delete(currencyPair: currencyPair)
    }
}
