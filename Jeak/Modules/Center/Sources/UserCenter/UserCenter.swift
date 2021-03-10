//
//  UserCenter.swift
//  Center
//
//  Created by Flutter on 2021/3/10.
//

import Foundation
import RPC
import Standard

public enum UserCenter {}

extension UserCenter: TypeName {}

extension UserCenter {
    private(set) static var guid: String {
        get {
            UserDefaults.standard.string(forKey: "xxx-guid") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "xxx-guid")
        }
    }
}

public extension UserCenter {
    static var isLogin: Bool { true }
}


public extension UserCenter {
    static func login(mobile: String,password: String,complete: @escaping (Result<Jeak_NormalLoginResponse, Error>) -> Void) {
        RPCCenter.jeak.login(mobile: mobile, password: password) { result in
            switch result {
            case .success(let response):
                UserCenter.guid = response.guid
            default: break
            }
            complete(result)
        }
    }
}


