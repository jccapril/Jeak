//
//  OverviewSimpleViewController.swift
//  App
//
//  Created by Flutter on 2021/4/15.
//

import UICore
import RxCocoa
import RxSwift


protocol OverviewSimpleViewControllerDelegate: AnyObject{
    // 定义协议方法
    func viewControllerDidSelectedType(type:Int64)
}

class OverviewSimpleViewController: ViewController {
    
    weak var delegate: OverviewSimpleViewControllerDelegate?
    lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(Theme.backgroundColor)
            .register(OverviewSimpleViewModel.Reusable.cell)
            .instance
    }()
    
    lazy var viewModel:OverviewSimpleViewModel = {
        let lazy = OverviewSimpleViewModel()
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
        let input = OverviewSimpleViewModel.Input()
        let output = viewModel.transform(input: input)
        handleItems(items: output.items)
        output.loadingState.distinctUntilChanged().asObservable()
            .subscribe (onNext: { state in
                if(state) {
                    self.view.hideToastActivity()
                }else {
                    self.view.makeToastActivity(.center)
                }
            })
            .disposed(by: disposeBag)
        viewModel.loadFirst()
        
    }
    
    func bindListView(_ tableView: UITableView) {
        tableView.rx.modelSelected(OverviewLotteryCellViewModel.self)
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
        
        items.subscribe { result in
            self.view.hideAllToasts()
        }.disposed(by: disposeBag)
        
        items.bind(to: tableView.rx.items(OverviewSimpleViewModel.Reusable.cell)){ (row, element, cell) in
            
        }
        .disposed(by: disposeBag)
    }
}

private extension OverviewSimpleViewController  {
    func detailClick(viewModel: OverviewLotteryCellViewModel){
        self.delegate?.viewControllerDidSelectedType(type: viewModel.data?.type ?? 0)
    }
}



