//
//  Chain.UIScrollView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIScrollView

public extension LeafBox where T: UIScrollView {
    @discardableResult
    func decelerationRate(_ decelerationRate: UIScrollView.DecelerationRate) -> LeafBox<T> {
        value.decelerationRate = decelerationRate
        return value.leaf
    }

    @discardableResult
    func isDirectionalLockEnabled(_ isDirectionalLockEnabled: Bool) -> LeafBox<T> {
        value.isDirectionalLockEnabled = isDirectionalLockEnabled
        return value.leaf
    }

    @discardableResult
    func bounces(_ bounces: Bool) -> LeafBox<T> {
        value.bounces = bounces
        return value.leaf
    }

    @discardableResult
    func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> LeafBox<T> {
        value.alwaysBounceVertical = alwaysBounceVertical
        return value.leaf
    }

    @discardableResult
    func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> LeafBox<T> {
        value.alwaysBounceHorizontal = alwaysBounceHorizontal
        return value.leaf
    }

    @discardableResult
    func isPagingEnabled(_ isPagingEnabled: Bool) -> LeafBox<T> {
        value.isPagingEnabled = isPagingEnabled
        return value.leaf
    }

    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> LeafBox<T> {
        value.isScrollEnabled = isScrollEnabled
        return value.leaf
    }

    @discardableResult
    func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> LeafBox<T> {
        value.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return value.leaf
    }

    @discardableResult
    func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> LeafBox<T> {
        value.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return value.leaf
    }
}

