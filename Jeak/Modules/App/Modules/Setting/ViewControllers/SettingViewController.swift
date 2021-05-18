//
//  SettingViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore
import Center
class SettingViewController: ViewController {
    
    
    lazy var updateBtn: UIButton = {
        UIButton(type: .system)
            .leaf
            .titleText(title: "UPDATE", for: .normal)
            .instance
    }()
    
    lazy var updateLabel: UILabel = {
        UILabel()
            .leaf
            .text("172.16.12.89:443")
            .instance
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateBtn.leaf.add(to: view)
        updateBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 100, height: 40))
            $0.center.equalToSuperview()
        }
        updateBtn.rx.controlEvent(.touchUpInside).subscribe { event in
            if self.updateLabel.text == "118.24.73.244:1443" {
                RPCCenter.jeak.update(host: "172.16.12.89", port: 443, tls: false)
                self.updateLabel.text = "172.16.12.89:443"
            }else {
                RPCCenter.jeak.update(host: "118.24.73.244", port: 1443, tls: false)
                self.updateLabel.text = "118.24.73.244:1443"
            }
            
        }
        .disposed(by: disposeBag)
        
        
        updateLabel.leaf.add(to: view)
        updateLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.updateBtn.snp_topMargin)
            $0.centerX.equalToSuperview()
        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
