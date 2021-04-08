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
    
    var viewController: UINavigationController {
        switch self {
        case .overview:
            return OverviewNavigationController()
        case .mine:
            return MineNavigationController()
        case .setting:
            return SettingNavigationController()
        }
    }
    
    var icon:UIImage {
        switch self {
        case .overview:
            return TabBarItemModular.image(named: "ic_tabbar_item_home_normal")!
        case .mine:
            return TabBarItemModular.image(named: "ic_tabbar_item_mine")!
        case .setting:
            return TabBarItemModular.image(named: "ic_tabbar_item_setting_normal")!
        }
    }
    
    var selectedIcon:UIImage {
        switch self {
        case .overview:
            return TabBarItemModular.image(named: "ic_tabbar_item_home_selected")!
        case .mine:
            return TabBarItemModular.image(named: "ic_tabbar_item_min")!
        case .setting:
            return TabBarItemModular.image(named: "ic_tabbar_item_setting_selected")!
        }
    }
    
    var displayTitle: String {
        return TabBarItemModular.localizedString(key: self.rawValue)
    }
    
}
