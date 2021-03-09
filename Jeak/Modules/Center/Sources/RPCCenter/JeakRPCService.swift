//
//  JeakRPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC


public final class JeakRPCService: RPCService {
    #if HX_APPSTORE
        private let host = "api.jeak.com"
    #else
        private let host = "127.0.0.1"
    #endif
    private let port = 443

    private let resultQueue = DispatchQueue.main
    private let requestQueue = DispatchQueue(label: typeName)

    public init() {
        super.init(host: host, port: port)
    }
}


public extension JeakRPCService {
    func callOptions(additionHeader: [(String, String)] = []) -> CallOptions {
        let sessionID = UserDefaults.standard.string(forKey: "sessionId") ?? ""
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""

        let defaultHeaders = [
            ("X-jeak-SID", sessionID),
            ("x-jeak-bid", bundleID),
            ("x-jeak-version", version),
        ]

        let allHeaders = defaultHeaders + additionHeader
        return CallOptions(
            customMetadata: .init(allHeaders),
            timeLimit: .timeout(.seconds(10)),
            cacheable: true
        )
    }
}


public extension JeakRPCService {
//    func login(account: String, password: string, complete: @escaping (Result<, Error>) -> Void) ){
//
//    }
}
