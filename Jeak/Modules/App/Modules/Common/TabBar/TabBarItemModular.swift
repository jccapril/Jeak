//
//  TabBarItemModular.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UIKit
import Standard

class TabBarItemModular: Modular {}


extension TabBarItemModular {
    static func image(named name: String) -> UIImage? {
        UIImage(named: name, in: TabBarItemModular.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
    }
}
