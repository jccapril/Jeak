//
//  OverviewListViewModel.swift
//  App
//
//  Created by Flutter on 2021/6/1.
//

import Foundation
import RxCocoa
import RxSwift
import Center
import RPC
import Service
import UICore

class OverviewListViewModel {
    enum Reusable {
        static let cell = ReusableCell<LotteryTableViewCell>()
    }
    var contents: [BaseCellViewModel] {
        elements.value
    }
    var type : Int64
    var page : UInt64 = 1
    let refreshState = BehaviorRelay(value: LotteryTableView.RefreshState.pull)
    let message = BehaviorRelay(value: "")
    let loadingState = BehaviorRelay(value: false)
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
    
    init(type:Int64) {
        self.type = type
    }

}


extension OverviewListViewModel: RxBaseCellViewModel {
    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    struct Output {
        let refreshState: Driver<LotteryTableView.RefreshState>
        let loadingState: Driver<Bool>
        let items: BehaviorRelay<[BaseCellViewModel]>
        let message: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        bindHeaderRefresh(input.headerRefresh)
        bindFooterRefresh(input.footerRefresh)
        return Output(
            refreshState: refreshState.asDriver(),
            loadingState: loadingState.asDriver(),
            items: elements,
            message: message.asDriver()
        )
    }
}

extension OverviewListViewModel {
    func bindHeaderRefresh(_ headerRefresh: Observable<Void>) {
        guard let disposeBag = self.disposeBag else { return }
        headerRefresh.skip(0)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.refreshState.accept(.pull)
                self.page = 1
                self.loadDataSource()
            })
            .disposed(by: disposeBag)
    }
    func bindFooterRefresh(_ headerRefresh: Observable<Void>) {
        guard let disposeBag = self.disposeBag else { return }
        headerRefresh.skip(0)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.refreshState.accept(.more)
                self.page+=1
                self.loadDataSource()
            })
            .disposed(by: disposeBag)
    }
}


extension OverviewListViewModel {
    func loadDataSource() {
        guard let disposeBag = self.disposeBag else { return }
        GetLotteryList()
            .subscribe(onNext: { result in
                self.handleResult(lotteryList: result)
            }, onError: { err in
                guard let e = err as? ResponseError else { return }
                guard let ecode = e.ecodeError else { return }
                self.loadingState.accept(true)
                self.message.accept(ecode.errMsg)
            }, onCompleted: {
                
            })
            .disposed(by: disposeBag)
    }
    
    
    func handleResult(lotteryList:[Jeak_Lottery]?){
        if self.page == 1 {
            self.elements.accept([])
        }
        var array = [BaseCellViewModel]()
        for lottery in lotteryList ?? [] {
            let viewModel = OverviewLotteryCellViewModel(identifier:Reusable.cell.identifier, data: lottery)
            array.append(viewModel)
        }
        handleElements(array)
    }
    
    
}


extension OverviewListViewModel {
    func handleElements(_ elements: [BaseCellViewModel]) {
        self.elements.accept(self.elements.value + elements)
        self.loadingState.accept(true)
        if self.elements.value.isEmpty {
            refreshState.accept(.empty)
        }else {
            refreshState.accept(.normal)
        }
    }
}


extension OverviewListViewModel {

    func GetLotteryList() -> Observable<[Jeak_Lottery]?> {
        Observable<[Jeak_Lottery]?>.create { observer in

            LotteryCenter.getLotteryList(page: self.page, type: self.type, complete: { result in
                switch result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let lottery):
                    observer.onNext(lottery)
                    observer.onCompleted()
                }
            })
            
            return Disposables.create()
        }
    }
    
   
}

