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
    
}


private extension MineViewController {
 
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: NaviagtionBarModular.image(named: "ic_naviagtion_item_back"), style: .plain, target: self, action: #selector(goBack(sender:)))
        
//        backButton.leaf.add(to: self.view)
//        backButton.snp.makeConstraints{
//            $0.leading.equalTo(20)
//            $0.top.equalTo(Adaptor.statusBarHeight + 10)
//            $0.size.equalTo(CGSize(width: 60, height: 60))
//        }
        
        
    }
    
    @objc
    func goBack(sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
