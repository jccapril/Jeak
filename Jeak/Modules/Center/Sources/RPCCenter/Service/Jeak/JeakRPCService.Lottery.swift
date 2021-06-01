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
    
    func GetLastestLottery(complete: @escaping (Result<Jeak_Gateway_GetLastestLotteryResponse, Error>) -> Void) {
        requestQueue.async {
            let client = Jeak_Gateway_LotteryClient(channel: self.connection,
                                                    defaultCallOptions: self.callOptions(),
                                                    interceptors: JeakClientInterceptorFactory())
            let call = client.getLastestLottery(.with {_ in

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
    
    func GetLotteryList(type:Int64,page:UInt64,complete: @escaping (Result<Jeak_Gateway_GetLotteriesResponse, Error>) -> Void) {
        requestQueue.async {
            let client = Jeak_Gateway_LotteryClient(
                channel: self.connection,
                defaultCallOptions: self.callOptions(),
                interceptors: JeakClientInterceptorFactory())
            let call = client.getLotteries(.with {
                $0.type = type
                $0.page = page
                $0.perPage = 10
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
