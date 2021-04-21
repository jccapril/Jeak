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

class OverviewViewModel {
        
    var contents: [BaseCellViewModel] {
        elements.value
    }
    
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
}

extension OverviewViewModel {
    func loadFirst() {
        guard let disposeBag = self.disposeBag else { return }
        
        let ssq = GetLastLotterySSQ()
        let dlt = GetLastLotteryDLT()

        Observable.zip(ssq, dlt) { result1, result2 in
            (result1, result2)
        }
        .subscribe { result1, result2 in
            self.handleFirstResult(ssq: result1, dlt: result2)
        }
        .disposed(by: disposeBag)
        

    }
    
    
    func handleFirstResult(ssq:JKLottery?,dlt:JKLottery?){
        print(ssq ?? "")
        print(ssq?.redBalls ?? [])
        print(dlt?.redBalls ?? [])
    }
}


extension OverviewViewModel {

    func GetLastLotterySSQ() -> Observable<JKLottery?>{
        Observable<JKLottery?>.create { observer in
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
    
    func GetLastLotteryDLT() -> Observable<JKLottery?>{
        Observable<JKLottery?>.create { observer in
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
