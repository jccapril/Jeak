//
//  OverviewListViewController.swift
//  App
//
//  Created by Flutter on 2021/6/1.
//

import UICore
import RxCocoa
import RxSwift

class OverviewListViewController: ViewController {
    
    var type:Int64
    lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(Theme.backgroundColor)
            .register(OverviewListViewModel.Reusable.cell)
            .instance
    }()
    
    lazy var viewModel:OverviewListViewModel = {
        let lazy = OverviewListViewModel(type: type)
        lazy.disposeBag = disposeBag
        return lazy
    }()
    
    init(type:Int64) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OverviewListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = self.type == 0 ? "双色球" : "大乐透"
        setupUI()
        bindRx()
    }
    
}


private extension OverviewListViewController {
    
    func setupUI() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: NaviagtionBarModular.image(named: "ic_naviagtion_item_back"), style: .plain, target: self, action: #selector(goBack(sender:)))
        
        tableView.leaf.add(to: view)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: Adaptor.navibarHeight, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    
}

private extension OverviewListViewController  {
    func bindRx() {
        
        bindListView(tableView)
        let input = OverviewListViewModel.Input()
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
        viewModel.loadDataSource()
        
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
        
        items.bind(to: tableView.rx.items(OverviewListViewModel.Reusable.cell)){ (row, element, cell) in
            
        }
        .disposed(by: disposeBag)
    }
}

private extension OverviewListViewController  {
    func detailClick(viewModel: OverviewLotteryCellViewModel){
        
    }
    
    @objc
    func goBack(sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
