//
//  Chain.UICollectionViewLayout.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UICollectionViewLayout

extension UICollectionViewFlowLayout: Leaf {}

public extension LeafBox where T: UICollectionViewFlowLayout {
    @discardableResult
    func itemSize(_ itemSize: CGSize) -> LeafBox<T> {
        value.itemSize = itemSize
        return value.leaf
    }

    @discardableResult
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> LeafBox<T> {
        value.minimumInteritemSpacing = minimumInteritemSpacing
        return value.leaf
    }

    @discardableResult
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> LeafBox<T> {
        value.minimumLineSpacing = minimumLineSpacing
        return value.leaf
    }

    @discardableResult
    func scrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> LeafBox<T> {
        value.scrollDirection = scrollDirection
        return value.leaf
    }

    @discardableResult
    func estimatedItemSize(_ estimatedItemSize: CGSize) -> LeafBox<T> {
        value.estimatedItemSize = estimatedItemSize
        return value.leaf
    }

    @discardableResult
    func sectionInset(_ sectionInset: UIEdgeInsets) -> LeafBox<T> {
        value.sectionInset = sectionInset
        return value.leaf
    }

    @discardableResult
    func headerReferenceSize(_ headerReferenceSize: CGSize) -> LeafBox<T> {
        value.headerReferenceSize = headerReferenceSize
        return value.leaf
    }

    @discardableResult
    func footerReferenceSize(_ footerReferenceSize: CGSize) -> LeafBox<T> {
        value.footerReferenceSize = footerReferenceSize
        return value.leaf
    }

    @discardableResult
    func sectionHeadersPinToVisibleBounds(_ sectionHeadersPinToVisibleBounds: Bool) -> LeafBox<T> {
        value.sectionHeadersPinToVisibleBounds = sectionHeadersPinToVisibleBounds
        return value.leaf
    }

    @discardableResult
    func sectionFootersPinToVisibleBounds(_ sectionFootersPinToVisibleBounds: Bool) -> LeafBox<T> {
        value.sectionFootersPinToVisibleBounds = sectionFootersPinToVisibleBounds
        return value.leaf
    }
}

