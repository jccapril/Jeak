//
//  OverviewViewModel.swift
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

class OverviewViewModel {
    enum Reusable {
        static let cell = ReusableCell<LotterySimpleTableViewCell>()
    }
    var contents: [BaseCellViewModel] {
        elements.value
    }
    let loadingState = BehaviorRelay(value: false)
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
    
}

extension OverviewViewModel: RxBaseCellViewModel {
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


extension OverviewViewModel {
    func loadFirst() {
        guard let disposeBag = self.disposeBag else { return }
        
        let ssq = GetLastLotterySSQ()
        let dlt = GetLastLotteryDLT()

        Observable.zip(ssq, dlt) { result1, result2 in
            (result1, result2)
        }.subscribe(onNext: { result1,result2 in
            self.loadingState.accept(true)
            self.handleFirstResult(ssq: result1, dlt: result2)
        }, onError: { err in
            self.loadingState.accept(true)
        }, onCompleted: {
        })
        .disposed(by: disposeBag)

        
    }
    
    
    func handleFirstResult(ssq:Jeak_Lottery?,dlt:Jeak_Lottery?){
       
        self.elements.accept([])
        var array = [BaseCellViewModel]()
        
        if ssq != nil {
            let ssqViewModel = OverviewSimpleCellViewModel(identifier:Reusable.cell.identifier, data: ssq)
            array.append(ssqViewModel)
        }
        
        if dlt != nil {
            let dltViewModel = OverviewSimpleCellViewModel(identifier:Reusable.cell.identifier, data: dlt)
            array.append(dltViewModel)
        }
        handleElements(array)
        
    }
}


extension OverviewViewModel {
    func handleElements(_ elements: [BaseCellViewModel]) {
        self.elements.accept(self.elements.value + elements)
        
    }
}


extension OverviewViewModel {

    func GetLastLotterySSQ() -> Observable<Jeak_Lottery?>{
        Observable<Jeak_Lottery?>.create { observer in
            LotteryCenter.getLastLotterySSQ { result in
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
    
    func GetLastLotteryDLT() -> Observable<Jeak_Lottery?>{
        Observable<Jeak_Lottery?>.create { observer in
            LotteryCenter.getLastLotteryDLT { result in
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
