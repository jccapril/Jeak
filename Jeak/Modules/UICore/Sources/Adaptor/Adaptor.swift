//
//  Adaptor.swift
//  UICore
//
//  Created by Flutter on 2021/3/22.
//

import Foundation
import UIKit

public enum Adaptor {}

public extension Adaptor {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let safeAreaTopHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    static let safeAreaBottomHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    static let statusHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
}

