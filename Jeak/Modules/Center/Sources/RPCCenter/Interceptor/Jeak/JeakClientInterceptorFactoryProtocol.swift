//
//  JeakClientInterceptorFactoryProtocol.swift
//  Center
//
//  Created by Flutter on 2021/5/26.
//

import Foundation
import GRPC
import NIO
import RPC


protocol JeakClientInterceptorFactoryProtocol: Jeak_Gateway_LotteryClientInterceptorFactoryProtocol{}

extension JeakClientInterceptorFactoryProtocol {
    
    public func makeGetLotteriesInterceptors() -> [ClientInterceptor<Jeak_Gateway_GetLotteriesRequest, Jeak_Gateway_GetLotteriesResponse>] {
        [
            LoggingEchoClientInterceptor(),
            ResponseHandlerInterceptor(),
        ]
    }
    
    public func makeGetLastestLotteryInterceptors() -> [ClientInterceptor<Jeak_Gateway_GetLastestLotteryRequest, Jeak_Gateway_GetLastestLotteryResponse>] {
        [
            LoggingEchoClientInterceptor(),
            ResponseHandlerInterceptor(),
        ]
    }
    
}
