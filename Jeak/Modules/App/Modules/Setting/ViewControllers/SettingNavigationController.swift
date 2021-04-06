//
//  SettingNavigationViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UIKit

class SettingNavigationController: UINavigationController {

    public init() {
        super.init(rootViewController: SettingViewController(nibName: nil, bundle: nil))
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tabBarItem = UITabBarItem(title: TabBarItem.setting.displayTitle, image: nil, selectedImage: nil)
    }
}
