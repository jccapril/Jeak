//
//  MineNavigationController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UIKit

class MineNavigationController: UINavigationController {

    public init() {
        super.init(rootViewController: MineViewController(nibName: nil, bundle: nil))
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tabBarItem = UITabBarItem(title: TabItem.mine.displayTitle, image: nil, selectedImage: nil)
    }
}
