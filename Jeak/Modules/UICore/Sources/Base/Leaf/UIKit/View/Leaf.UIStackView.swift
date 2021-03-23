//
//  Chain.UIStackView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIStackView

@available(iOS 9.0, *)
public extension LeafBox where T == UIStackView {
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> LeafBox<T> {
        value.axis = axis
        return value.leaf
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> LeafBox<T> {
        value.distribution = distribution
        return value.leaf
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> LeafBox<T> {
        value.alignment = alignment
        return value.leaf
    }

    @discardableResult
    func spacing(_ spacing: CGFloat) -> LeafBox<T> {
        value.spacing = spacing
        return value.leaf
    }
}

