//
//  Chain.UIView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit


extension UIView: Leaf {}

public extension LeafBox where T: UIView {
    @discardableResult
    func isHidden(_ isHidden: Bool) -> LeafBox<T> {
        value.isHidden = isHidden
        return value.leaf
    }
    
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool = true) -> LeafBox<T> {
        value.clipsToBounds = clipsToBounds
        return value.leaf
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> LeafBox<T> {
        value.backgroundColor = color
        return value.leaf
    }

    @discardableResult
    func contentMode(_ contentModel: UIView.ContentMode = .scaleToFill) -> LeafBox<T> {
        value.contentMode = contentModel
        return value.leaf
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor?) -> LeafBox<T> {
        value.tintColor = tintColor
        return value.leaf
    }
    
    @discardableResult
    func border(color: UIColor?, width: CGFloat) -> LeafBox<T> {
        value.layer.borderColor = color?.cgColor
        value.layer.borderWidth = width
        return value.leaf
    }
    
    @discardableResult
    func shadow(color: UIColor?, offset: CGSize, opacity: Float, radius: CGFloat) -> LeafBox<T> {
        value.layer.shadowColor = color?.cgColor
        value.layer.shadowOffset = offset
        value.layer.shadowOpacity = opacity
        value.layer.shadowRadius = radius
        return value.leaf
    }
    
    @discardableResult
    func corners(_ corners: UIRectCorner = .allCorners, radius: CGFloat, isReset: Bool = false) -> LeafBox<T> {
        value.layoutIfNeeded()

        if #available(iOS 11, *) {
            value.layer.cornerRadius = radius
            var maskedCorners = CACornerMask()
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            value.layer.maskedCorners = maskedCorners
        } else {
            if corners == .allCorners {
                value.layer.cornerRadius = radius
            } else {
                if isReset { value.layer.cornerRadius = 0 }
                let path = UIBezierPath(roundedRect: value.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                value.layer.mask = mask
            }
        }

        value.layer.masksToBounds = true

        return value.leaf
    }
    
    
    @discardableResult
    func add(to superView: UIView) -> T {
        superView.addSubview(value)
        return value
    }
    
}
