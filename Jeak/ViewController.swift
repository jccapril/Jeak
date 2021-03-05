//
//  ViewController.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var box = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.view.addSubview(box)
        box.backgroundColor = .blue
        
        
    }


}

