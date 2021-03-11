//
//  ViewController.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
import SnapKit
import Center
//import RxSwift
//import RxCocoa
import Toast

/**
 
 RxSwift 文档
 https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
 */

class ViewController: UIViewController {
    
    lazy var button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        button.setTitle("HelloWord", for: .normal)
        button.frame = CGRect(x: 50, y: 100, width: 100, height: 50)
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
        self.view.makeToastActivity(.center)
        UserCenter.login(mobile:"18301787178" , password: "123123") { (result) in
            self.view.hideToastActivity()
            switch result {
            case .success(let response):
                if response.errCode == 0 {
                    print("Call Status : \(response)")
                    self.view.makeToast("SUCCESS", duration: 1.0, position: .center)
                }else {
                    self.view.makeToast("FAILURE", duration: 1.0, position: .center)
                }
                
            
            case .failure(let error):
                print("Call Failed With Error : \(error)")
                self.view.makeToast("FAILURE", duration: 1.0, position: .center)
                break
            }
        }
        

    }

}

