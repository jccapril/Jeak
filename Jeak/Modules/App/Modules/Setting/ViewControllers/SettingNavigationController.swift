//
//  SettingNavigationViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class SettingNavigationController: NavigationController {

    public init() {
        super.init(rootViewController: SettingViewController(nibName: nil, bundle: nil))
        setupTabBarItem()
    }

}


extension SettingNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

private extension SettingNavigationController {
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: TabBarItem.setting.displayTitle, image: TabBarItem.setting.icon, selectedImage: TabBarItem.setting.selectedIcon)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .normal)
    }
}
