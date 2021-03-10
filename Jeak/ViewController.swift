//
//  ViewController.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
//import SnapKit
import Center


class ViewController: UIViewController {
    
    lazy var button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        button.setTitle("HelloWord", for: .normal)
        button.frame = CGRect(x: 50, y: 100, width: 100, height: 50)
//        button.frame(forAlignmentRect: CGRect(x: 50, y: 100, width: 100, height: 50))
        button.addTarget(self, action: #selector(helloWorld(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
//        button.snp.makeConstraints {
//            $0.width.equalTo(100)
//            $0.height.equalTo(50)
//            $0.center.equalToSuperview()
//        }
  
    }

    @objc
    func helloWorld(sender:UIButton) {
        
        UserCenter.login(mobile:"18301787178" , password: "123123") { (result) in
            switch result {
            case .success(let response):
                if response.errCode == 0 {
                    print("Call Status : \(response)")
                }
            
            case .failure(let error):
                print("Call Failed With Error : \(error)")
                break
            }
        }
        

    }

}

