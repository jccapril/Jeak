//
//  Chain.UIWindow.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit

public extension LeafBox where T: UIWindow {
    @discardableResult
    @available(iOS 13.0, *)
    func windowScene(_ windowScene: UIWindowScene?) -> LeafBox<T> {
        value.windowScene = windowScene
        return value.leaf
    }

    @discardableResult
    func canResizeToFitContent(_ canResizeToFitContent: Bool) -> LeafBox<T> {
        value.canResizeToFitContent = canResizeToFitContent
        return value.leaf
    }

    @discardableResult
    func screen(_ screen: UIScreen) -> LeafBox<T> {
        value.screen = screen
        return value.leaf
    }

    @discardableResult
    func windowLevel(_ windowLevel: UIWindow.Level) -> LeafBox<T> {
        value.windowLevel = windowLevel
        return value.leaf
    }

    @discardableResult
    func becomeKey() -> LeafBox<T> {
        value.becomeKey()
        return value.leaf
    }

    @discardableResult
    func resignKey() -> LeafBox<T> {
        value.resignKey()
        return value.leaf
    }

    @discardableResult
    func makeKey() -> LeafBox<T> {
        value.makeKey()
        return value.leaf
    }

    @discardableResult
    func makeKeyAndVisible() -> LeafBox<T> {
        value.makeKeyAndVisible()
        return value.leaf
    }

    @discardableResult
    func rootViewController(_ rootViewController: UIViewController?) -> LeafBox<T> {
        value.rootViewController = rootViewController
        return value.leaf
    }

    @discardableResult
    func sendEvent(_ event: UIEvent) -> LeafBox<T> {
        value.sendEvent(event)
        return value.leaf
    }
}

