//
//  Chain.UITableView.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//

import UIKit.UITableView

public extension LeafBox where T: UITableView {
    @discardableResult
    func delegate(_ delegate: UITableViewDelegate?) -> LeafBox<T> {
        value.delegate = delegate
        return value.leaf
    }

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource?) -> LeafBox<T> {
        value.dataSource = dataSource
        return value.leaf
    }

    func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle = .singleLine) -> LeafBox<T> {
        value.separatorStyle = separatorStyle
        return value.leaf
    }

    @discardableResult
    func separatorInset(_ separatorInset: UIEdgeInsets) -> LeafBox<T> {
        value.separatorInset = separatorInset
        return value.leaf
    }

    @discardableResult
    func registerCell(_ cellClass: AnyClass?, _ identifier: String) -> LeafBox<T> {
        value.register(cellClass, forCellReuseIdentifier: identifier)
        return value.leaf
    }

    @discardableResult
    func registerHeaderOrFooter(_ itemClass: AnyClass?, _ identifier: String) -> LeafBox<T> {
        value.register(itemClass, forHeaderFooterViewReuseIdentifier: identifier)
        return value.leaf
    }

    @discardableResult
    func estimatedHeight(_ rowHeight: CGFloat = 0,
                         _ sectionHeaderHeight: CGFloat = 0,
                         _ SectionFooterHeight: CGFloat = 0) -> LeafBox<T>
    {
        value.estimatedRowHeight = rowHeight
        value.estimatedSectionHeaderHeight = sectionHeaderHeight
        value.estimatedSectionFooterHeight = SectionFooterHeight
        return value.leaf
    }

    @discardableResult
    func disableContentInset(_ disableContentInset: Bool) -> LeafBox<T> {
        if #available(iOS 11, *) {
            value.contentInsetAdjustmentBehavior = .never
        }
        return value.leaf
    }

    func tableHeaderView(_ tableHeaderView: UIView?) -> LeafBox<T> {
        value.tableHeaderView = tableHeaderView
        return value.leaf
    }

    func tableFooterView(_ tableFooterView: UIView?) -> LeafBox<T> {
        value.tableFooterView = tableFooterView
        return value.leaf
    }
}
