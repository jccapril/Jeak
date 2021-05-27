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
    
    func GetLastestLottery(hasSSQ:Bool,hasDLT:Bool,complete: @escaping (Result<Jeak_Gateway_GetLastestLotteryResponse, Error>) -> Void) {
        requestQueue.async {
            let client = Jeak_Gateway_LotteryClient(channel: self.connection,
                                                    defaultCallOptions: self.callOptions(),
                                                    interceptors: JeakClientInterceptorFactory())
            let call = client.getLastestLottery(.with {
                $0.dlt = hasDLT
                $0.ssq = hasSSQ
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
    
    func GetLotteryList(type:Int64,complete: @escaping (Result<Jeak_Gateway_GetLotteriesResponse, Error>) -> Void) {
        requestQueue.async {
            let client = Jeak_Gateway_LotteryClient(
                channel: self.connection,
                defaultCallOptions: self.callOptions(),
                interceptors: JeakClientInterceptorFactory())
            let call = client.getLotteries(.with {
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
