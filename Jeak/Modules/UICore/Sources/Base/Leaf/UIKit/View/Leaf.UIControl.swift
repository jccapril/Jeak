//
//  Chain.UIControl.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIControl

public extension LeafBox where T: UIControl {
    @discardableResult
    func enabled(_ isEnabled: Bool) -> LeafBox<T> {
        value.isEnabled = isEnabled
        return value.leaf
    }

    @discardableResult
    func selected(_ isSelected: Bool) -> LeafBox<T> {
        value.isSelected = isSelected
        return value.leaf
    }

    @discardableResult
    func highlighted(_ isHighlighted: Bool) -> LeafBox<T> {
        value.isHighlighted = isHighlighted
        return value.leaf
    }

    @discardableResult
    func contentVerticalAlignment(_ contentVerticalAlignment: UIControl.ContentVerticalAlignment) -> LeafBox<T> {
        value.contentVerticalAlignment = contentVerticalAlignment
        return value.leaf
    }

    @discardableResult
    func contentHorizontalAlignment(_ contentHorizontalAlignment: UIControl.ContentHorizontalAlignment) -> LeafBox<T> {
        value.contentHorizontalAlignment = contentHorizontalAlignment
        return value.leaf
    }
}

