//
//  RPCService.Remote.swift
//  Center
//
//  Created by Flutter on 2021/4/21.
//

import Foundation
import Storage

extension RPCService {
    struct Remote: Codable {
        let host: String
        let port: Int
        let tls: Bool

        init(host: String, port: Int, tls: Bool) {
            self.host = host
            self.port = port
            self.tls = tls
        }
    }
}

extension RPCService.Remote: CodableStorable {}
