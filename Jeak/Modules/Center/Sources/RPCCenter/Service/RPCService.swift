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

    private let name: String
    
    private(set) var connection: ClientConnection

//    let logger = Loggers[typeName]


    
    public init(name: String, host: String, port: Int, tls: Bool) {
        precondition(!name.isEmpty, "name should not be empty")
        self.name = name
        if tls {
            connection = ClientConnection.secure(group: group).connect(host: host, port: port)
        }else {
            connection = ClientConnection.insecure(group: group).connect(host: host, port: port)
        }

    }


    deinit {
        try? group.syncShutdownGracefully()
    }
    
}

extension RPCService {
    func change(host: String, port: Int, tls: Bool) {
        do {
            try connection.close().wait()
        } catch {
            print("\(error)")
        }
        if tls {
            connection = ClientConnection.secure(group: group).connect(host: host, port: port)
        }else {
            connection = ClientConnection.insecure(group: group).connect(host: host, port: port)
        }
    }
}

extension RPCService: TypeName {}
