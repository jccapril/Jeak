//
//  EqutableExampleViewController.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore


struct EquatableEmaple: Equatable {
    var name: String
    var age: Int
}

class EquatableExampleViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        
        let a = EquatableEmaple(name: "a", age: 1)
        let b = EquatableEmaple(name: "a", age: 1)
        print(a==b)
        
    }
    

}


extension EquatableExampleViewController {
    
    func setup() {
        
        self.title = "Equatable Example"
        
    }
    
}
