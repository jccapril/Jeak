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
    lazy var contentView: OverviewListContentView = {
        let contentView = OverviewListContentView(frame: .zero)
        return contentView
    }()
    
    lazy var viewModel:OverviewListViewModel = {
        let lazy = OverviewListViewModel(type: type)
        lazy.disposeBag = disposeBag
        return lazy
    }()
    // rx
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
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
        setupRefresh()
    }
    
}


private extension OverviewListViewController {
    
    func setupUI() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: NaviagtionBarModular.image(named: "ic_naviagtion_item_back"), style: .plain, target: self, action: #selector(goBack(sender:)))
        
        contentView.leaf.add(to: view).snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(Adaptor.navibarHeight)
        }
        
    }
    
    
}


private extension OverviewListViewController {
    func setupRefresh() {
        let tableView = contentView.listView
        tableView.configRefreshHeader(with: tableView.header, container: self) { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        }
        tableView.configRefreshFooter(with: tableView.footer, container: self) { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        }
    }
}


private extension OverviewListViewController  {
    func bindRx() {
        
        bindListView(contentView.listView)
        let input = OverviewListViewModel.Input(
            headerRefresh: headerRefreshTrigger.asObserver(),
            footerRefresh: footerRefreshTrigger.asObserver()
        )
        let output = viewModel.transform(input: input)
        handleItems(items: output.items)
        output.loadingState.distinctUntilChanged().drive(contentView.rx.loadState)
            .disposed(by: disposeBag)
        output.message.drive(contentView.rx.errMsg)
            .disposed(by: disposeBag)
        output.refreshState.distinctUntilChanged().drive(contentView.listView.rx.refreshState).disposed(by: disposeBag)
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
        
        items.bind(to: contentView.listView.rx.items(OverviewListViewModel.Reusable.cell)){ (row, element, cell) in
            
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
