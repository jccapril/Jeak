//
//  RPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC
import NIO
//import LogMan
import Standard


open class RPCService {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

    let connection: ClientConnection

//    let logger = Loggers[typeName]

    public init(host: String, port: Int) {
        // 没有使用TLS 就用insecure
        connection = ClientConnection.insecure(group: group).connect(host: host, port: port)
//        connection = ClientConnection.secure(group: group).connect(host: host, port: port)
    }

    deinit {
        try? group.syncShutdownGracefully()
    }
}

extension RPCService: TypeName {}
