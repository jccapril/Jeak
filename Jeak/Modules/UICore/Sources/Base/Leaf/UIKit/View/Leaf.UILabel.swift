//
//  Chain.UILabel.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UILabel

public extension LeafBox where T: UILabel {
    @discardableResult
    func text(_ text: String?) -> LeafBox<T> {
        value.text = text
        return value.leaf
    }

    @discardableResult
    func textColor(_ color: UIColor) -> LeafBox<T> {
        value.textColor = color
        return value.leaf
    }

    @discardableResult
    func font(_ font: UIFont) -> LeafBox<T> {
        value.font = font
        return value.leaf
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> LeafBox<T> {
        value.textAlignment = textAlignment
        return value.leaf
    }

    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> LeafBox<T> {
        value.numberOfLines = numberOfLines
        return value.leaf
    }

    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> LeafBox<T> {
        value.lineBreakMode = lineBreakMode
        return value.leaf
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> LeafBox<T> {
        value.attributedText = attributedText
        return value.leaf
    }
}
