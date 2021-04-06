//
//  TabBarItem.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

enum TabBarItem: String {
    case overview = "TabBar.Item.Overview.Title"
    case mine = "TabBar.Item.Mine.Title"
    case setting = "TabBar.Item.Setting.Title"
    
    var viewController: ViewController {
        switch self {
        case .overview:
            return OverviewViewController()
        case .mine:
            return MineViewController()
        case .setting:
            return SettingViewController()
        }
    }
    
    var icon:UIImage {
        switch self {
        case .overview:
            return UIImage(named: "ic_overview")!
        case .mine:
            return UIImage(named: "ic_mine")!
        case .setting:
            return UIImage(named: "ic_setting")!
        }
    }
    
    var displayTitle: String {
        return TabBarItemModular.localizedString(key: self.rawValue)
    }
    
}
