//
//  enum.lottery.swift
//  App
//
//  Created by Flutter on 2021/3/23.
//


enum JKLotteryType: Int {
    case ssq    = 0
    case dlt    = 1
    case fc3d   = 2
    case pl3    = 3
    
    func toString()->String{
        var a:String
        switch self{
        case .ssq:
            a="双色球"
        case .dlt:
            a="大乐透"
        case .fc3d:
            a="福彩3D"
        case .pl3:
            a="排列3"
        }
        return a
    }
}
