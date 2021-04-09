//
//  MineNavigationController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class MineNavigationController: NavigationController {

    public init() {
        super.init(rootViewController: MineViewController(nibName: nil, bundle: nil))
        setupTabBarItem()
    }
    

    

}


extension MineNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

private extension MineNavigationController {
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: TabBarItem.mine.displayTitle, image: nil, selectedImage: nil)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.tabbarItemTitleColor], for: .normal)
    }
}
