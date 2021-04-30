//
//  Date.format.swift
//  Service
//
//  Created by Flutter on 2021/4/22.
//

import Foundation

public extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
