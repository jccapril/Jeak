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
    var lotteryDate: Date { get }
    var lotteryPhase: Int64 { get }
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
        red.split(separator: "|").compactMap { "\($0)" }
    }
    var blueBalls: [String] {
        blue.split(separator: "|").compactMap { "\($0)" }
    }
    var lotteryDate: Date {
        Date(timeIntervalSince1970: TimeInterval(date))
    }
    var lotteryPhase: Int64 {
        phase
    }
    var lotteryFirstPrizeCount: Int64 {
        firstPrizeCount
    }
    var lotteryFirstPrizeMoney: Int64 {
        firstPrizeMoney
    }
    var lotteryRewardPoolMoney: Int64 {
        rewardPoolMoney
    }
    
}




