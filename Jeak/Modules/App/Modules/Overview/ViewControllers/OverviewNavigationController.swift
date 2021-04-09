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
        setupTabBarItem()
    }
    
    
}

extension OverviewNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

private extension OverviewNavigationController {
    
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: TabBarItem.overview.displayTitle, image: TabBarItem.overview.icon, selectedImage: TabBarItem.overview.selectedIcon)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .normal)
    }
    

}


