//
//  JKMainViewController.swift
//  App
//
//  Created by Flutter on 2021/3/23.
//

import UICore

class JKMainViewController: ViewController {

    private var childrenControllers: [JKDashboardViewController]?

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
        
        navigationController?.isNavigationBarHidden = true

        
    }
    
}
