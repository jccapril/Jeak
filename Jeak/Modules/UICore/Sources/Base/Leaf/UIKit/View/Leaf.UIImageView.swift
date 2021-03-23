//
//  Chain.UIImageView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UIImageView

public extension LeafBox where T: UIImageView {
    @discardableResult
    func image(_ image: UIImage?) -> LeafBox<T> {
        value.image = image
        return value.leaf
    }
}
