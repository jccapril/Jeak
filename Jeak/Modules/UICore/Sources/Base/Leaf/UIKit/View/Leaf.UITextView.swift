//
//  Chain.UITextView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UITextView

public extension LeafBox where T: UITextView {
    @discardableResult
    func delegate(_ delegate: UITextViewDelegate?) -> LeafBox<T> {
        value.delegate = delegate
        return value.leaf
    }

    @discardableResult
    func text(_ text: String?) -> LeafBox<T> {
        value.text = text
        return value.leaf
    }

    @discardableResult
    func font(_ font: UIFont?) -> LeafBox<T> {
        value.font = font
        return value.leaf
    }

    @discardableResult
    func textColor(_ textColor: UIColor?) -> LeafBox<T> {
        value.textColor = textColor
        return value.leaf
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> LeafBox<T> {
        value.textAlignment = textAlignment
        return value.leaf
    }

    @discardableResult
    func isEditable(_ isEditable: Bool) -> LeafBox<T> {
        value.isEditable = isEditable
        return value.leaf
    }

    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> LeafBox<T> {
        value.isSelectable = isSelectable
        return value.leaf
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> LeafBox<T> {
        value.attributedText = attributedText
        return value.leaf
    }

    @discardableResult
    func textContainerInset(_ textContainerInset: UIEdgeInsets) -> LeafBox<T> {
        value.textContainerInset = textContainerInset
        return value.leaf
    }

    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> LeafBox<T> {
        value.returnKeyType = returnKeyType
        return value.leaf
    }

    @discardableResult
    func enablesReturnKeyAutomatically(_ enablesReturnKeyAutomatically: Bool) -> LeafBox<T> {
        value.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        return value.leaf
    }

    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> LeafBox<T> {
        value.autocorrectionType = autocorrectionType
        return value.leaf
    }
}

