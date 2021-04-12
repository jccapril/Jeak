//
//  File.swift
//  Center
//
//  Created by Flutter on 2021/4/12.
//

import Foundation
import Standard
import Storage

public enum StorageCenter {}

extension StorageCenter: TypeName {}

private extension StorageCenter {
    static let rootURL: URL = {
        do {
            let documentURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let rootURL = documentURL.appendingPathComponent(typeName)
            return rootURL
        } catch { fatalError("\(error)") }
    }()
}


public extension StorageCenter {
    static let jeak: StoreContainer = {
        do {
            let pathUrl = rootURL.appendingPathComponent("jeak")
            if !FileManager.default.fileExists(atPath: pathUrl.path) {
                try FileManager.default.createDirectory(at: pathUrl, withIntermediateDirectories: true, attributes: nil)
            }
            return try StoreContainer(path: pathUrl.path)
        } catch {
            fatalError("\(error)")
        }
    }()
}
