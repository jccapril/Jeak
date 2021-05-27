//
//  Response.swift
//  Center
//
//  Created by Flutter on 2021/5/27.
//

import Foundation
import GRPC
import NIOHPACK
import RPC
import SwiftProtobuf

extension Data {
    init?(base64Unpadded string: String) {
        let length = string.count
        self.init(base64Encoded: string.padding(toLength: length + (4 - length % 4) % 4, withPad: "=", startingAt: 0))
    }
}

public struct ResponseError: Error {
    let rpcStatus: GRPCStatus
    public let ecodeError: Ecode_Error?
}

class ResponseHandlerInterceptor<Request, Response>: ClientInterceptor<Request, Response> {
    override func receive(_ part: GRPCClientResponsePart<Response>, context: ClientInterceptorContext<Request, Response>) {
        switch part {
        case .end(let status, let headers):
            switch status.code {
            case .ok:
                // 正常情况，直接返回
                context.receive(part)
                return
            case .unauthenticated:
                // 未登录，需要重新登录
                context.logger.warning("unauthenticated: kick out")
//                UserCenter.forceLogout()
                return
            default:
                // 其他异常
                context.logger.warning("status.code: \(headers)")
                let ecodeError = getEcodeError(byHeaders: headers)
                context.errorCaught(ResponseError(rpcStatus: status, ecodeError: ecodeError))
            }
        default:
            context.receive(part)
        }
    }

    func getEcodeError(byHeaders headers: HPACKHeaders) -> Ecode_Error? {
        guard let statusDetails = headers.first(name: "grpc-status-details-bin") else { return nil }
        guard let detailData = Data(base64Unpadded: statusDetails) else { return nil }
        guard let grpcStatus = try? Google_Rpc_Status(serializedData: detailData) else { return nil }
        guard !grpcStatus.details.isEmpty else { return nil }
        for detail in grpcStatus.details {
            switch detail.typeURL {
            case "type.googleapis.com/ecode.Error":
                return try? Ecode_Error(serializedData: detail.value)
            default:
                break
            }
        }
        return nil
    }
}

