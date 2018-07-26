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
    @IBOutlet var tableView: UITableView!
    private lazy var datasource = self.createDatasource()
    
    @IBOutlet  var base: UILabel!
    @IBOutlet var value: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rates & convertions"
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func bind(reactor: CurrencyReactor) {
        value.rx.text.orEmpty
            .debounce(0.4, scheduler: MainScheduler.instance)
            .map {
                Double($0) }
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
        return RxTableViewSectionedAnimatedDataSource<CurrenciesSection>(configureCell: { (ds, tv, ip, currency) in
            let cell = tv.dequeueReusableCell(withIdentifier: self.identifier, for: ip) as! CurrencyTableViewCell
            cell.render(currency: currency, enabled: false)
            return cell
        })
    }
}

