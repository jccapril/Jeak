//
//  File.swift
//  App
//
//  Created by Flutter on 2021/6/2.
//

import UICore
import UIKit

class OverviewListContentView: UIView {
    
    lazy var listView: LotteryTableView = {
        LotteryTableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(Theme.backgroundColor)
            .register(OverviewListViewModel.Reusable.cell)
            .instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension OverviewListContentView {
    func setupUI() {
        listView.leaf.add(to: self).snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

extension Reactive where Base: OverviewListContentView {
    var loadState: Binder<Bool> {
        Binder(base) { view, state in
            if(state) {
                view.hideToastActivity()
            }else {
                view.makeToastActivity(.center)
            }
        }
    }
    var errMsg: Binder<String> {
        Binder(base) { view, message in
            guard !message.isEmpty else { return }
            view.makeToast(message,position: .center)
        }
    }
}

