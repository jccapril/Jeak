//
//  CommonModule.swift
//  App
//
//  Created by Flutter on 2021/4/9.
//

import Foundation
import UIKit
import Standard

public class CommonModular: Modular {
    static func image(named name: String) -> UIImage? {
        UIImage(named: name, in: CommonModular.bundle, compatibleWith: nil)
    }
}
