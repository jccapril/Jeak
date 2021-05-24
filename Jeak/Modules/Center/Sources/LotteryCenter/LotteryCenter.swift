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
    
    static func getLastestLotteryList(complete: @escaping (Result<[Jeak_Lottery]?, Error>) -> Void) {
        RPCCenter.jeak.GetLastestLottery(hasSSQ: true, hasDLT: true) { result in
            switch result {
                case .success(let response):
                    if response.errCode != 0 {
                        complete(.success(nil))
                    }else {
                        let lottery = response.lottery
                        complete(.success(lottery))
                    }
                case .failure(let error):
                    complete(.failure(error))
            }
            
        }
    }
    
    static func getSSQLotteryList(complete: @escaping (Result<[Jeak_Lottery]?, Error>) -> Void) {
        RPCCenter.jeak.GetLotteryList(type:0) { result in
            switch result {
            case .success(let response):
                if response.errCode != 0 {
                    complete(.success(nil))
                }else {
                    let lottery = response.lottery
                    complete(.success(lottery))
                }
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
    
    static func getDLTLotteryList(complete: @escaping (Result<[Jeak_Lottery]?, Error>) -> Void) {
        RPCCenter.jeak.GetLotteryList(type:1) { result in
            switch result {
            case .success(let response):
                if response.errCode != 0 {
                    complete(.success(nil))
                }else {
                    let lottery = response.lottery
                    complete(.success(lottery))
                }
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
    
}
