//
//  JeakRPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC
import RPC


public final class JeakRPCService: RPCService {
    #if JEAK_PRODUCT
        private let host = "api.jeak.com"
    #else
        private let host = "127.0.0.1"
    #endif
    private let port = 443
    
    private let timeout = 10

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
            ("X-JEAK-SID", sessionID),
            ("X-JEAK-BID", bundleID),
            ("X-JEAK-VERSION", version),
        ]

        let allHeaders = defaultHeaders + additionHeader
        return CallOptions(
            customMetadata: .init(allHeaders),
            timeLimit: .timeout(.seconds(Int64(timeout))),
            cacheable: true
        )
    }
}


public extension JeakRPCService {
    
    func login(mobile: String, password: String, complete: @escaping(Result<Jeak_NormalLoginResponse,Error>)->Void) {
        requestQueue.async {
            let client = Jeak_LoginClient(channel: self.connection,defaultCallOptions: self.callOptions())
            let call = client.normalLogin(.with{
                $0.mobile = mobile
                $0.password = password
            })
            call.response.whenComplete {result in
                self.resultQueue.async {
                    complete(result)
                }
            }
            do {
                let status = try call.status.wait()
                print("Call Status : \(status)")
            } catch {
                print("Call Failed With Error : \(error)")
            }
        }
    }
    
}
