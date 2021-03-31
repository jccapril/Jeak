//
//  JKLotteryListViewModel.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import Foundation
import RxSwift
import RxCocoa

class JKLotteryListViewModel {
    
    
    let lotteryType: Driver<JKLotteryType>
//    let lotteryList: [JKLottery]
    
    init(selectedSegmentIndex:Driver<Int>) {
        
        lotteryType = selectedSegmentIndex.map{ index in
            return (JKLotteryType.init(rawValue: index) ?? .ssq)
        }
        
    }
}


