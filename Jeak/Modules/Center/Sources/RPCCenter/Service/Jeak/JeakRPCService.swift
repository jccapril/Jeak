//
//  JeakRPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC
import RPC
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
//            ("X-JEAK-SID", sessionID),
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
                print("inner Call Status : \(status)")
            } catch {
                print("inner Call Failed With Error : \(error)")
            }
        }
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
        static let host: String = ""
    #else
        static let host: String = "192.168.3.22"
    #endif

    static let port: Int = 443
    static let name: String = "jeak"
    static let remote = Remote(host: host, port: port, tls: true)

    static let remoteKey: String = "\(typeName)/\(name)/remote"
}
