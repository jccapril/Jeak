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
    let loadingState = BehaviorRelay(value: false)
    let elements = BehaviorRelay<[BaseCellViewModel]>(value: [])
    var disposeBag: DisposeBag?
    
    init(type:Int64) {
        self.type = type
    }

}


extension OverviewListViewModel: RxBaseCellViewModel {
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


extension OverviewListViewModel {
    func loadDataSource() {
        guard let disposeBag = self.disposeBag else { return }
        GetLotteryList()
            .subscribe(onNext: { result in
                self.loadingState.accept(true)
                self.handleResult(lotteryList: result)
            }, onError: { err in
                self.loadingState.accept(true)
            }, onCompleted: {
                
            })
            .disposed(by: disposeBag)
    }
    
    
    func handleResult(lotteryList:[Jeak_Lottery]?){
        self.elements.accept([])
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

