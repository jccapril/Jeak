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
        setup()
    }
    

    

}


extension SettingNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension SettingNavigationController {
    func setup() {
        tabBarItem = UITabBarItem(title: TabBarItem.setting.displayTitle, image: TabBarItem.setting.icon, selectedImage: TabBarItem.setting.selectedIcon)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .normal)
    }
}
