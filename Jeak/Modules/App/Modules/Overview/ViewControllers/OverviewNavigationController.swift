//
//  MineNavigationController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UIKit

class OverviewNavigationController: UINavigationController {

    public init() {
        super.init(rootViewController: OverviewViewController(nibName: nil, bundle: nil))
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tabBarItem = UITabBarItem(title: TabItem.overview.displayTitle, image: nil, selectedImage: nil)
    }
}
