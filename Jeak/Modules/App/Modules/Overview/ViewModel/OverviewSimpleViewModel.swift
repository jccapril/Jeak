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
    let loadingState = BehaviorRelay(value: false)
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
    
}

extension OverviewSimpleViewModel: RxBaseCellViewModel {
    struct Input {
        
    }
    struct Output {
        let loadingState: Driver<Bool>
        let items: BehaviorRelay<[BaseCellViewModel]>
    }
    
    func transform(input: Input) -> Output {
        return Output(
            loadingState: loadingState.asDriver(),
            items: elements
        )
    }
}


extension OverviewSimpleViewModel {
    func loadFirst() {
        guard let disposeBag = self.disposeBag else { return }
        
        GetLastestLotteryList()
            .subscribe(onNext: { result in
                self.loadingState.accept(true)
                self.handleFirstResult(lotteryList: result)
            }, onError: { err in
                self.loadingState.accept(true)
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
