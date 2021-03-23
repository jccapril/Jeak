//
//  Chain.UICollectionView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UICollectionView

public extension LeafBox where T: UICollectionView {
    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate?) -> LeafBox<T> {
        value.delegate = delegate
        return value.leaf
    }

    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource?) -> LeafBox<T> {
        value.dataSource = dataSource
        return value.leaf
    }

    @discardableResult
    func register(_ cellClass: AnyClass?, _ identifier: String) -> LeafBox<T> {
        value.register(cellClass, forCellWithReuseIdentifier: identifier)
        return value.leaf
    }
    
    @discardableResult
    func registerSupplementary(_ itemClass: AnyClass?, _ elementKind: String, _ identifier: String) -> LeafBox<T> {
        value.register(itemClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return value.leaf
    }

    @discardableResult
    func disableContentInset(_ disableContentInset: Bool = true) -> LeafBox<T> {
        if #available(iOS 11, *) {
            value.contentInsetAdjustmentBehavior = .never
        }
        return value.leaf
    }
}

