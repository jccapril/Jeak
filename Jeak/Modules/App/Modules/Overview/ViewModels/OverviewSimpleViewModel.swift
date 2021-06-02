//
//  OverviewSimpleViewModel.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import Foundation
import RxCocoa
import RxSwift
import Center
import RPC
import Service
import UICore

class OverviewSimpleViewModel {
    enum Reusable {
        static let cell = ReusableCell<LotteryTableViewCell>()
    }
    var contents: [BaseCellViewModel] {
        elements.value
    }
    let refreshState = BehaviorRelay(value: LotteryTableView.RefreshState.pull)
    let loadingState = BehaviorRelay(value: false)
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
    
}

extension OverviewSimpleViewModel: RxBaseCellViewModel {
    struct Input {
        let headerRefresh: Observable<Void>
//        let footerRefresh: Observable<Void>
    }
    struct Output {
        let refreshState: Driver<LotteryTableView.RefreshState>
        let loadingState: Driver<Bool>
        let items: BehaviorRelay<[BaseCellViewModel]>
    }
    
    func transform(input: Input) -> Output {
        bindHeaderRefresh(input.headerRefresh)
//        bindFooterRefresh(input.footerRefresh)
        return Output(
            refreshState: refreshState.asDriver(),
            loadingState: loadingState.asDriver(),
            items: elements
        )
    }
}

extension OverviewSimpleViewModel {
    func bindHeaderRefresh(_ headerRefresh: Observable<Void>) {
        guard let disposeBag = self.disposeBag else { return }
        headerRefresh.skip(0)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.refreshState.accept(.pull)
                self.loadDataSource()
            })
            .disposed(by: disposeBag)
    }
//    func bindFooterRefresh(_ headerRefresh: Observable<Void>) {
//        guard let disposeBag = self.disposeBag else { return }
//        headerRefresh.skip(0)
//            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.refreshState.accept(.pull)
//                self.loadDataSource()
//            })
//            .disposed(by: disposeBag)
//    }
}


extension OverviewSimpleViewModel {
    func loadDataSource() {
        guard let disposeBag = self.disposeBag else { return }
        GetLastestLotteryList()
            .subscribe(onNext: { result in
                self.handleFirstResult(lotteryList: result)
            }, onError: { err in
                guard let e = err as? ResponseError else { return }
                guard let ecode = e.ecodeError else { return }
                print("find code \(ecode)")
            }, onCompleted: {
                
            })
            .disposed(by: disposeBag)
        
//        let ssq = GetLastLotterySSQ()
//        let dlt = GetLastLotteryDLT()

//        Observable.zip(ssq, dlt) { result1, result2 in
//            (result1, result2)
//        }.subscribe(onNext: { result1,result2 in
//            self.loadingState.accept(true)
//            self.handleFirstResult(ssq: result1, dlt: result2)
//        }, onError: { err in
//            self.loadingState.accept(true)
//        }, onCompleted: {
//        })
//        .disposed(by: disposeBag)
        
    }
    
    
    func handleFirstResult(lotteryList:[Jeak_Lottery]?){
       
        self.elements.accept([])
        var array = [BaseCellViewModel]()
        
        for lottery in lotteryList ?? [] {
            let viewModel = OverviewLotteryCellViewModel(identifier:Reusable.cell.identifier, data: lottery)
            array.append(viewModel)
        }
        
        handleElements(array)
        
    }
}


extension OverviewSimpleViewModel {
    func handleElements(_ elements: [BaseCellViewModel]) {
        
        self.elements.accept(self.elements.value + elements)
        self.loadingState.accept(true)
        if self.elements.value.isEmpty {
            refreshState.accept(.empty)
        }else {
            refreshState.accept(.end)
        }
    }
}


extension OverviewSimpleViewModel {

    func GetLastestLotteryList() -> Observable<[Jeak_Lottery]?> {
        Observable<[Jeak_Lottery]?>.create { observer in
            LotteryCenter.getLastestLotteryList { result in
                switch result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let lottery):
                    observer.onNext(lottery)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
   
}
