//
//  ViewController.swift
//  CurrencyChecker
//
//  Created by Антон Назаров on 23/07/2018.
//  Copyright © 2018 Антон Назаров. All rights reserved.
//

import UIKit
import RxDataSources
import ReactorKit
import RxSwift
import RxCocoa
import RxSwiftExt

class CurrencyTableViewController: UIViewController, StoryboardView {
    var disposeBag: DisposeBag = DisposeBag()
    private let identifier = "CurrencyTableViewCell" // too small project to make it cleaner
    @IBOutlet private var tableView: UITableView!
    // swiftlint:disable:next private_outlet
    @IBOutlet var base: UILabel!
    @IBOutlet private var value: UITextField!
    private lazy var datasource = self.createDatasource()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rates & convertions"
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func bind(reactor: CurrencyReactor) {
        value.rx.text.orEmpty
                .debounce(0.4, scheduler: MainScheduler.instance)
                .map(Double.init)
                .unwrap()
                .filter { $0 != reactor.currentState.value }
                .map { CurrencyReactor.Action.type(value: $0) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)

        reactor.state.map { $0.currencies }
                     .map { [CurrenciesSection(title: "Currencies", items: Array($0.suffix(from: 1)))] }
                     .bind(to: tableView.rx.items(dataSource: datasource))
                     .disposed(by: disposeBag)

        reactor.state.map { $0.currencies }
                     .map { $0[0].name }
                     .bind(to: base.rx.text)
                     .disposed(by: disposeBag)

        // swiftlint:disable:next trailing_closure
        tableView.rx.modelSelected(Currency.self)
                    .subscribe(onNext: { [unowned self] in
                        self.reactor?.action.onNext(.select(currency: $0))
                        self.reactor?.action.onNext(.type(value: $0.value))
                    })
                    .disposed(by: disposeBag)
    }
}

// MARK: - Private
private extension CurrencyTableViewController {
    func createDatasource() -> RxTableViewSectionedAnimatedDataSource<CurrenciesSection> {
        // swiftlint:disable:next trailing_closure
        return RxTableViewSectionedAnimatedDataSource<CurrenciesSection>(
                configureCell: { _, tableView, indexPath, currency in
                    // swiftlint:disable:next force_cast
                    let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! CurrencyTableViewCell
                    cell.render(currency: currency, enabled: false)
                    return cell
                })
    }
}
