//
//  JKMainViewController.swift
//  App
//
//  Created by Flutter on 2021/3/23.
//

import UICore
import Coder
class JKMainViewController: UITabBarController {

    lazy var jkTabBar: TabBar = {
        let lazy = TabBar()
        lazy.jkDelegate = self
        return lazy
    }()
    
}

// MARK: - TabBarDelegate

extension JKMainViewController: TabBarDelegate {
    
    func tabBar(_ tabBar: TabBar, didClickCenterButton button: UIButton) {
        
        let mine = MineViewController()
        let current = self.selectedViewController as! NavigationController
        mine.hidesBottomBarWhenPushed = true
        current.pushViewController(mine, animated: true)
    }
}

// MARK: - Override

extension JKMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadTabBar()
        

    }


}


private extension JKMainViewController {
    
    func loadTabBar() {
        // We'll create and load our custom tab bar here
        self.setValue(jkTabBar, forKey: "tabBar")
        let tabItems: [TabBarItem] = [.overview,.setting]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0 // default our selected index to the first item
        
    }
    func setupCustomTabBar(_ menuItems: [TabBarItem], completion: @escaping ([UIViewController]) -> Void) {
        completion(menuItems.map{$0.viewController})
    }
    
}
