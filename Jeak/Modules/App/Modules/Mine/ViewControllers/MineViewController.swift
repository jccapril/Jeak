//
//  MineViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class MineViewController: ViewController {

    lazy var backButton:UIButton = {
        UIButton()
            .leaf
            .image(NaviagtionBarModular.image(named: "ic_naviagtion_item_back"), for: .normal)
            .instance
    }()
    
}

extension MineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
    
}


private extension MineViewController {
 
    func setupUI() {

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: NaviagtionBarModular.image(named: "ic_naviagtion_item_back"), style: .plain, target: self, action: #selector(goBack(sender:)))
        
        
    }
    
    @objc
    func goBack(sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
