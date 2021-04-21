//
//  JeakRPCService.Overview.swift
//  Center
//
//  Created by Flutter on 2021/4/21.
//

import Foundation
import GRPC
import RPC

public extension JeakRPCService {
    
    func GetLastLottery(type:Int64,complete: @escaping (Result<Jeak_Gateway_GetLastLotteryResponse, Error>) -> Void) {
        requestQueue.async {
            let client = Jeak_Gateway_LotteryClient(channel: self.connection, defaultCallOptions: self.callOptions())
            let call = client.getLastLottery(.with {
                $0.type = type
            })
            call.response.whenComplete { result in self.resultQueue.async { complete(result) } }
            do {
                let status = try call.status.wait()
                print("Call Status : \(status)")
            } catch {
                print("Call Failed With Error : \(error)")
            }
        }
    }
   
}
