//
//  MineNavigationController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class OverviewNavigationController: NavigationController {

    public init() {
        super.init(rootViewController: OverviewViewController(nibName: nil, bundle: nil))
        setup()
    }
    
    
}

extension OverviewNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension OverviewNavigationController {
    func setup() {
        tabBarItem = UITabBarItem(title: TabBarItem.overview.displayTitle, image: TabBarItem.overview.icon, selectedImage: TabBarItem.overview.selectedIcon)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .normal)
    }
}
