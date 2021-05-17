//
//  JKLottery.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import Foundation
import Center
import RPC

protocol JKLottery {
    var lotteryName: String { get }
    var lotteryType: JKLotteryType { get }
    var redBalls: [String] { get }
    var blueBalls: [String] { get }
    var lotteryDate: String { get }
    var lotteryCode: String { get }
    var lotteryFirstPrizeCount: Int64 { get }
    var lotteryFirstPrizeMoney: Int64 { get }
    var lotteryRewardPoolMoney: Int64 { get }
}

extension Jeak_Lottery: JKLottery {
    
    var lotteryName: String {
        name
    }
    var lotteryType: JKLotteryType {
        JKLotteryType.init(rawValue: Int(type)) ?? .ssq
    }
    var redBalls: [String] {
        red
    }
    var blueBalls: [String] {
        blue
    }
    var lotteryDate: String {
        date
    }
    var lotteryCode: String {
        code
    }
    var lotteryFirstPrizeCount: Int64 {
        firstCount
    }
    var lotteryFirstPrizeMoney: Int64 {
        firstMoney
    }
    var lotteryRewardPoolMoney: Int64 {
        poolMoney
    }
    
}




