//
//  JKLottery.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import Foundation


protocol JKLottery {
    var lotteryType: JKLotteryType { get set }
}

struct JKLotterySSQ: JKLottery {
    var lotteryType: JKLotteryType = .ssq
    var red: String
    var blue: String
}

