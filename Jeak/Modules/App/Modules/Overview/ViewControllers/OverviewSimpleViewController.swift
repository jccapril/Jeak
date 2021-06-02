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
    
    lazy var contentView: OverviewSimpleContentView = {
        let contentView = OverviewSimpleContentView(frame: .zero)
        return contentView
    }()
    lazy var viewModel:OverviewSimpleViewModel = {
        let lazy = OverviewSimpleViewModel()
        lazy.disposeBag = disposeBag
        return lazy
    }()
    // Rx
    let headerRefreshTrigger = PublishSubject<Void>()
//    let footerRefreshTrigger = PublishSubject<Void>()
}

extension OverviewSimpleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindRx()
        setupRefresh()
    }
    
}

private extension OverviewSimpleViewController {
    
    func setupUI() {
        
        contentView.leaf.add(to: view).snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(Adaptor.navibarHeight)
        }
    }
    
}

private extension OverviewSimpleViewController {
    func setupRefresh() {
        let tableView = contentView.listView
        tableView.configRefreshHeader(with: tableView.header, container: self) { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        }

//        tableView.configRefreshFooter(with: tableView.footer, container: self) { [weak self] in
//            self?.footerRefreshTrigger.onNext(())
//        }
    }
}


private extension OverviewSimpleViewController  {
    func bindRx() {
        let tableView = contentView.listView
        bindListView(tableView)
        let input = OverviewSimpleViewModel.Input(
            headerRefresh: headerRefreshTrigger.asObserver()
//            footerRefresh: footerRefreshTrigger.asObserver()
        )
        let output = viewModel.transform(input: input)
        handleItems(items: output.items)
        output.loadingState.distinctUntilChanged().drive(rx.loadState)
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
        
        items.subscribe { result in
            self.view.hideAllToasts()
        }.disposed(by: disposeBag)
        
        items.bind(to: contentView.listView.rx.items(OverviewSimpleViewModel.Reusable.cell)){ (row, element, cell) in
            
        }
        .disposed(by: disposeBag)
    }
}

private extension OverviewSimpleViewController  {
    func detailClick(viewModel: OverviewLotteryCellViewModel){
        self.delegate?.viewControllerDidSelectedType(type: viewModel.data?.type ?? 0)
    }
}



extension Reactive where Base: OverviewSimpleViewController {
    var loadState: Binder<Bool> {
        Binder(base) { controller, state in
            if(state) {
                controller.view.hideToastActivity()
            }else {
                controller.view.makeToastActivity(.center)
            }
        }
    }
}
