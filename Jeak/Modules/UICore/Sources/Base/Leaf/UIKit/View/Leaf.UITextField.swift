//
//  Chain.UITextField.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UITextField

public extension LeafBox where T: UITextField {
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
    func attributedText(_ attributedText: NSAttributedString?) -> LeafBox<T> {
        value.attributedText = attributedText
        return value.leaf
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> LeafBox<T> {
        value.textAlignment = textAlignment
        return value.leaf
    }

    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> LeafBox<T> {
        value.borderStyle = borderStyle
        return value.leaf
    }

    @discardableResult
    func placeholder(_ placeholder: String?) -> LeafBox<T> {
        value.placeholder = placeholder
        return value.leaf
    }

    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> LeafBox<T> {
        value.attributedPlaceholder = attributedPlaceholder
        return value.leaf
    }

    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> LeafBox<T> {
        value.delegate = delegate
        return value.leaf
    }

    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> LeafBox<T> {
        value.clearButtonMode = clearButtonMode
        return value.leaf
    }

    @discardableResult
    func leftView(_ leftView: UIView?, mode: UITextField.ViewMode) -> LeafBox<T> {
        value.leftView = leftView
        value.leftViewMode = mode
        return value.leaf
    }

    @discardableResult
    func rightView(_ rightView: UIView?, mode: UITextField.ViewMode) -> LeafBox<T> {
        value.rightView = rightView
        value.rightViewMode = mode
        return value.leaf
    }

    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool = true) -> LeafBox<T> {
        value.isSecureTextEntry = isSecureTextEntry
        return value.leaf
    }

    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> LeafBox<T> {
        value.autocapitalizationType = autocapitalizationType
        return value.leaf
    }

    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> LeafBox<T> {
        value.autocorrectionType = autocorrectionType
        return value.leaf
    }
}

