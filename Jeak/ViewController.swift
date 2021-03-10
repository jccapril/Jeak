//
//  ViewController.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
import SnapKit
import Center


class ViewController: UIViewController {
    
    lazy var button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button.setTitle("HelloWord", for: .normal)
        button.addTarget(self, action: #selector(helloWorld(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
  
    }

    @objc
    func helloWorld(sender:UIButton) {
        RPCCenter.jeak.login(mobile: "18301787178", password: "123123") { (result) in
            switch result {
            case .success(let response):
                if response.errCode == 0 {
                   print("aaa")
                }
            
            case .failure:
                print("bbb")
                break
            }
        }
    }

}

