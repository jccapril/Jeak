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
    static func stringConvertDate(string:String,dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = dateFormat
            let date = dateFormatter.date(from: string)
            return date!
    }
 
}
