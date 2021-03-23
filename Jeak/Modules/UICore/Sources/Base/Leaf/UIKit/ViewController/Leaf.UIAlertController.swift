//
//  Chain.UIAlertController.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIAlertController

extension UIAlertController: Leaf {}

public extension LeafBox where T: UIAlertController {
    @discardableResult
    func addAction(_ action: UIAlertAction) -> LeafBox<T> {
        value.addAction(action)
        return value.leaf
    }

    @discardableResult
    func addTextField(_ configurationHandler: ((UITextField) -> ())? = nil) -> LeafBox<T> {
        value.addTextField(configurationHandler: configurationHandler)
        return value.leaf
    }

    @discardableResult
    func show(in viewController: UIViewController) -> LeafBox<T> {
        viewController.present(value, animated: true)
        return value.leaf
    }
}
