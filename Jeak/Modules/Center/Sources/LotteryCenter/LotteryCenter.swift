//
//  LotteryCenter.swift
//  Center
//
//  Created by Flutter on 2021/4/21.
//

import Foundation
import RPC
import Standard
import GRPC
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
        RPCCenter.jeak.GetLastestLottery() { result in
            switch result {
                case .success(let response):
                    let lottery = response.lottery
                    complete(.success(lottery))
                case .failure(let error):
                    if let e = error as? ResponseError {
                        let status = e.rpcStatus.code
                        let code = e.ecodeError?.errCode ?? 0
                        print("find status \(status)")
                        print("find code \(code)")
                      } else {
                        // handle other err0or types
                      }
                    complete(.failure(error))
            }
            
        }
    }
    
    static func getLotteryList(page:UInt64,type: Int64,complete: @escaping (Result<[Jeak_Lottery]?, Error>) -> Void) {
        RPCCenter.jeak.GetLotteryList(type:type,page: page) { result in
            switch result {
            case .success(let response):
                let lottery = response.lottery
                complete(.success(lottery))
            case .failure(let error):
                complete(.failure(error))
            }
        }
    }
    

    
}
