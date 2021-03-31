//
//  JSONCoder.swift
//  Service
//
//  Created by Flutter on 2021/3/31.
//

import Foundation

public enum JSONCoder {}

private extension JSONCoder {
    static let encoder: JSONEncoder = {
        JSONEncoder()
    }()

    static let decoder: JSONDecoder = {
        JSONDecoder()
    }()
}

public extension JSONCoder {
    static func encode<Object: Encodable>(object: Object) throws -> Data {
        let bytes = try encoder.encode(object)
        return Data(bytes)
    }

    static func decode<Object: Decodable>(data: Data) throws -> Object {
        try decoder.decode(Object.self, from: data)
    }
}

