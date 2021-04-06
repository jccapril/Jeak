//
//  JKMainViewController.swift
//  App
//
//  Created by Flutter on 2021/3/23.
//

import UICore

class JKMainViewController: UITabBarController {
    public init(viewControllers: [UIViewController]?, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Override

extension JKMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

        
        
    
    }
}


private extension JKMainViewController {
    
    func setupUI() {
        
        
    }
    
}
