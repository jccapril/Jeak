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
        setup()
    }
    

    

}


extension MineNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension MineNavigationController {
    func setup() {
        tabBarItem = UITabBarItem(title: TabBarItem.mine.displayTitle, image: nil, selectedImage: nil)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .highlighted)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x9ca2c7)!], for: .normal)
    }
}
