//
//  OverviewViewModel.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import Foundation
import RxCocoa
import RxSwift

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
        
        let overview = getCurrentLotterys()
//        let overview2 = getCurrentLotterys()
//
//        Observable.zip(overview1,overview2) { result1,result2 in
//            (result1,result2)
//        }
//        .subscribe { result1, result2 in
//            self.handleFirstResult(lotterys: result1?.items)
//        }
//        .disposed(by: disposeBag)
        
        overview.subscribe { result in
            self.handleFirstResult(lotterys: result?.items)
        }
        .disposed(by: disposeBag)
        

    }
    
    
    func handleFirstResult(lotterys: [JKLottery]?){
        
    }
}


extension OverviewViewModel {
    
    struct GetCurrentLotterysResult {
        var items: [JKLottery]?
    }
    
    func getCurrentLotterys() -> Observable<GetCurrentLotterysResult?>{
        Observable<GetCurrentLotterysResult?>.create { observer in
//            ProgramCenter.getFriendRoomOverview { result in
//                switch result {
//                case .failure(let error):
//                    observer.onError(error)
//                case .success(let avatars):
//                    if (avatars?.isEmpty) != nil {
//                        observer.onNext(MyRoom(avatars: avatars))
//                    } else {
//                        observer.onNext(nil)
//                    }
//                    observer.onCompleted()
//                }
//            }
            
            observer.onNext(GetCurrentLotterysResult(items: []))
            
            return Disposables.create()
        }
    }
}
