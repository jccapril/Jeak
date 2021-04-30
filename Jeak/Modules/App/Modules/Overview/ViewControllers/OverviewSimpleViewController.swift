//
//  OverviewSimpleViewController.swift
//  App
//
//  Created by Flutter on 2021/4/15.
//

import UICore
import RxCocoa
import RxSwift
import Center

class OverviewSimpleViewController: ViewController {
    

    
    lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(Theme.backgroundColor)
            .register(OverviewViewModel.Reusable.cell)
            .instance
    }()
    
    lazy var viewModel:OverviewViewModel = {
        let lazy = OverviewViewModel()
        lazy.disposeBag = disposeBag
        return lazy
    }()
}

extension OverviewSimpleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindRx()
    }
    
}

private extension OverviewSimpleViewController {
    
    func setupUI() {
        
        tableView.leaf.add(to: view)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: Adaptor.navibarHeight, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    
}

private extension OverviewSimpleViewController  {
    func bindRx() {
        
        bindListView(tableView)
        viewModel.loadFirst()
        let input = OverviewViewModel.Input()
        let output = viewModel.transform(input: input)
        handleItems(items: output.items)
        
    }
    
    func bindListView(_ tableView: UITableView) {
        tableView.rx.modelSelected(OverviewSimpleCellViewModel.self)
            .subscribe(onNext: { [weak self] item in
                self?.detailClick(viewModel: item)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                guard let cellViewModel = self?.viewModel.contents[safe: indexPath.row] else { return }
                cellViewModel.willDisplay(cell: cell)
            })
            .disposed(by: disposeBag)
    }
    
    
    func handleItems(items: BehaviorRelay<[BaseCellViewModel]>) {
        items.bind(to: tableView.rx.items(OverviewViewModel.Reusable.cell)){ (row, element, cell) in
            
        }
        .disposed(by: disposeBag)
    }
}

private extension OverviewSimpleViewController  {
    func detailClick(viewModel: OverviewSimpleCellViewModel){
        
    }
}



