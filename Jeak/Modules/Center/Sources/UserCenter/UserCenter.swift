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

private extension UserCenter {
    static let store = StorageCenter.jeak[typeName]
}

extension UserCenter {
    private(set) static var guid: String {
        get {
            UserDefaults.standard.string(forKey: "xxx-guid") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "xxx-guid")
        }
    }
    
    private(set) static var userInfo: UserInfo? = {
        do {
            guard let userInfo: UserInfo = try store.sync.get() else { return nil }
            return userInfo
        } catch {
            print("\(error)")
            return nil
        }
    }() {
        didSet {
            do {
                switch userInfo {
                case .none:
                    try store.sync.delete(key: UserInfo.key)
                case .some(let userInfo):
                    try store.sync.put(storableObject: userInfo)
                }
            } catch {
                print("\(error)")
            }
        }
    }
    
}

public extension UserCenter {
    static var isLogin: Bool { true }
}


public extension UserCenter {
//    static func login(mobile: String,password: String,complete: @escaping (Result<Jeak_NormalLoginResponse, Error>) -> Void) {
//        RPCCenter.jeak.login(mobile: mobile, password: password) { result in
//            switch result {
//            case .success(let response):
//                UserCenter.guid = response.guid
//            default: break
//            }
//            complete(result)
//        }
//    }
    

}


