//
//  OverviewSimpleContentView.swift
//  App
//
//  Created by Flutter on 2021/6/2.
//

import UICore
import UIKit

class OverviewSimpleContentView: UIView {
    
    lazy var listView: LotteryTableView = {
        LotteryTableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(Theme.backgroundColor)
            .register(OverviewSimpleViewModel.Reusable.cell)
            .instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension OverviewSimpleContentView {
    func setupUI() {
        listView.leaf.add(to: self).snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
