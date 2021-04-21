//
//  RPCCenter.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import Standard

public enum RPCCenter {}

extension RPCCenter: TypeName {}

private extension RPCCenter {
    static let store = StorageCenter.jeak[typeName]
}

public extension RPCCenter {
    static let jeak = JeakRPCService(store: store)
}
