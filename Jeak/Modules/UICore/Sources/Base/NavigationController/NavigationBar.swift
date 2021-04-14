//
//  NavigationBar.swift
//  UICore
//
//  Created by Flutter on 2021/4/7.
//

import Foundation
import UIKit

public class NavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }
}

private extension NavigationBar {
    func setup() {
        if #available(iOS 11.0, *) {
            prefersLargeTitles = false
        }
        isExclusiveTouch = true
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        shadowImage = UIImage()
    }
}

extension NavigationBar {
//    override open var isHidden: Bool {
//        get { super.isHidden }
//        set {
//            switch newValue {
//            case true: fatalError("DO NOT HIDE NavigationBar")
//            case false: super.isHidden = newValue
//            }
//        }
//    }
}

