//
//  LotteryCenter.swift
//  Center
//
//  Created by Flutter on 2021/4/21.
//

import Foundation
import RPC
import Standard

public enum LotteryCenter {}

extension LotteryCenter: TypeName {}

public extension LotteryCenter {
    
    static func getLastLotterySSQ(complete: @escaping (Result<Jeak_Lottery, Error>) -> Void){
        RPCCenter.jeak.GetLastLottery(type: 0, complete: {
            result in
                switch result {
                case .success(let response):
                    let lottery = response.lottery
                    complete(.success(lottery))
                case .failure(let error):
                    complete(.failure(error))
                }
        })
    }
    
    
    static func getLastLotteryDLT(complete: @escaping (Result<Jeak_Lottery, Error>) -> Void){
        RPCCenter.jeak.GetLastLottery(type: 1, complete: {
            result in
                switch result {
                case .success(let response):
                    let lottery = response.lottery
                    complete(.success(lottery))
                case .failure(let error):
                    complete(.failure(error))
                }
        })
    }
    
}
