//
//  Chain.UIButton.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIButton

public extension LeafBox where T: UIButton {
    @discardableResult
    func titleFont(font: UIFont) -> LeafBox<T> {
        value.titleLabel?.font = font
        return value.leaf
    }

    @discardableResult
    func titleText(title: String?, for state: UIButton.State = .normal) -> LeafBox<T> {
        value.setTitle(title, for: state)
        return value.leaf
    }

    @discardableResult
    func titleColor(_ color: UIColor?, for state: UIButton.State = .normal) -> LeafBox<T> {
        value.setTitleColor(color, for: state)
        return value.leaf
    }

    @discardableResult
    func image(_ image: UIImage?, for state: UIButton.State = .normal) -> LeafBox<T> {
        value.setImage(image, for: state)
        return value.leaf
    }

    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIButton.State = .normal) -> LeafBox<T> {
        value.setBackgroundImage(image, for: state)
        return value.leaf
    }

    @discardableResult
    func targetAction(_ target: Any?, _ action: Selector, for event: UIControl.Event = .touchUpInside) -> LeafBox<T> {
        value.addTarget(target, action: action, for: event)
        return value.leaf
    }

    @discardableResult
    func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> LeafBox<T> {
        value.contentEdgeInsets = contentEdgeInsets
        return value.leaf
    }
}
