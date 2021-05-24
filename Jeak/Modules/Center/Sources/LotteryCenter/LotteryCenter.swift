//
//  LotteryCenter.swift
//  Center
//
//  Created by Flutter on 2021/4/21.
//

import Foundation
import RPC
import Standard

enum LotteryCenterError: Error {
    case BidInvalid
    case LotteryTypeInvalid
    case OtherInvalid
    
    private static let intValues:[LotteryCenterError:Int64] = [.BidInvalid:1002001,.LotteryTypeInvalid:1002002]
    private static let mappingDict:[Int64:LotteryCenterError] = Dictionary(uniqueKeysWithValues: LotteryCenterError.intValues.map({ ($1, $0) }))

    var intValue:Int64 {
        return LotteryCenterError.intValues[self]!
    }

    init(intValue:Int64){
        if let err =  LotteryCenterError.mappingDict[intValue] {
            self = err
        }else {
            self = .OtherInvalid
        }
    }
}

public enum LotteryCenter {}

extension LotteryCenter: TypeName {}

public extension LotteryCenter {
    
    static func getLastestLotteryList(complete: @escaping (Result<[Jeak_Lottery]?, Error>) -> Void) {
        RPCCenter.jeak.GetLastestLottery(hasSSQ: true, hasDLT: true) { result in
            switch result {
                case .success(let response):
                    if response.errCode != 0 {
                        complete(.failure(LotteryCenterError.init(intValue: response.errCode)))
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
                
                    complete(.failure(LotteryCenterError.init(intValue: response.errCode)))
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
                    complete(.failure(LotteryCenterError.init(intValue: response.errCode)))
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
