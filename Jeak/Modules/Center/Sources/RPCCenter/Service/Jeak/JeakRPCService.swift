//
//  JeakRPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC
import RPC
import Logging
import Storage

public final class JeakRPCService: RPCService {

    private let timeout = 10
    private let store: Store
    let resultQueue = DispatchQueue.main
    let requestQueue = DispatchQueue(label: typeName)

    public init(store: Store) {
        self.store = store
        let remote = (try? store.sync.get(key: Self.remoteKey)) ?? Self.remote
        super.init(name: Self.name, host: remote.host, port: remote.port, tls: remote.tls)
    }
}


public extension JeakRPCService {
    func callOptions(additionHeader: [(String, String)] = []) -> CallOptions {
//        let sessionID = UserDefaults.standard.string(forKey: "sessionId") ?? ""
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        let defaultHeaders = [
//            ("authorization","bearer grpc.auth.token"),
            ("x-jeak-bid", bundleID),
            ("x-jeak-version", version),
        ]
        let allHeaders = defaultHeaders + additionHeader
        return CallOptions(
            customMetadata: .init(allHeaders),
            timeLimit: .timeout(.seconds(Int64(timeout))),
            cacheable: true,
            logger:Logger.init(label: "jeak.io.grpc")
        )
    }
}

public extension JeakRPCService {
    func update(host: String, port: Int, tls: Bool) {
        change(host: host, port: port, tls: tls)
        let remote = Remote(host: host, port: port, tls: tls)
        store.async.put(value: remote, forKey: Self.remoteKey, complete: { _ in })
    }
}

private extension JeakRPCService {
    #if APPSTORE
        static let host: String = "djangoc.com"
        static let port: Int = 1443
    #else
        static let host: String = "172.16.12.89"
        static let port: Int = 443
    #endif
    

    static let name: String = "jeak"
    static let remote = Remote(host: host, port: port, tls: true)
    static let remoteKey: String = "\(typeName)/\(name)/remote"
}
