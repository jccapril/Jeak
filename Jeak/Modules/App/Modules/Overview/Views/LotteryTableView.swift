//
//  LotteryTableView.swift
//  App
//
//  Created by Flutter on 2021/6/2.
//

import RxCocoa
import RxSwift
import UICore
import PullToRefreshKit
import UIKit



class LotteryTableView: UITableView {
    enum RefreshState {
        case pull
        case normal
        case more
        case empty
        case end
    }
    
    lazy var footer: DefaultRefreshFooter = {
        let footer = DefaultRefreshFooter.footer()
        footer.setText(AppModular.localizedString(key: "Pull up to refresh"), mode: .pullToRefresh)
        footer.setText(AppModular.localizedString(key: "No data any more"), mode: .noMoreData)
        footer.setText(AppModular.localizedString(key: "Refreshing..."), mode: .refreshing)
        footer.setText(AppModular.localizedString(key: "Tap to load more"), mode: .tapToRefresh)
        footer.setText(AppModular.localizedString(key: "Scroll or tap to load"), mode: .scrollAndTapToRefresh)
        footer.textLabel.textColor = .orange
        footer.isHidden = true
        return footer
    }()

    lazy var header: DefaultRefreshHeader = {
        let header = DefaultRefreshHeader.header()
        header.setText(AppModular.localizedString(key: "Pull to refresh"), mode: .pullToRefresh)
        header.setText(AppModular.localizedString(key: "Release to refresh"), mode: .releaseToRefresh)
        header.setText(AppModular.localizedString(key: "Success"), mode: .refreshSuccess)
        header.setText(AppModular.localizedString(key: "Refreshing..."), mode: .refreshing)
        header.setText(AppModular.localizedString(key: "Failed"), mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        return header
    }()
    
}


extension Reactive where Base: LotteryTableView {
    var refreshState: Binder<LotteryTableView.RefreshState> {
        Binder(base) { listView, state in
            switch state {
            case .pull:
//                view.listView.showEmpty(false)
                listView.footer.isHidden = true
            case .normal:
                listView.switchRefreshHeader(to: .normal(.success, 0.2))
//                view.listView.showEmpty(false)
                listView.footer.isHidden = false
                listView.switchRefreshFooter(to: .normal)
            case .empty:
                listView.switchRefreshHeader(to: .normal(.success, 0.2))
//                view.listView.showEmpty(true)
                listView.footer.isHidden = true
            case .end:
                listView.switchRefreshHeader(to: .normal(.success, 0.2))
//                view.listView.showEmpty(false)
                listView.footer.isHidden = false
                listView.switchRefreshFooter(to: .noMoreData)
            case .more: break
            }
        }
    }
}
