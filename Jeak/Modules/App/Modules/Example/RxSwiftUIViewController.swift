//
//  RxSwiftUIViewController.swift
//  App
//
//  Created by 蒋晨成 on 2021/3/15.
//

import UICore


class RxSwiftUIViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testUITextField()
        
    }
    

}


extension RxSwiftUIViewController {
    
    
    func testUITextField(){
        
        let textTF = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        textTF.borderStyle = .roundedRect
        self.view.addSubview(textTF)
        
        let label = UILabel(frame: CGRect(x: 50, y: 150, width: 200, height: 30))
        label.textColor = .blue
        self.view.addSubview(label)
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 50, y: 180, width: 100, height: 30)
        btn.setTitle("登陆", for: .normal)
        self.view.addSubview(btn)
        
        
        let inputOB = textTF.rx.text.orEmpty.asDriver().throttle(RxTimeInterval.milliseconds(500))
        // asDriver
        // 映射一下 ---> 给我们的label
        inputOB.map { "当前输入了:\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        inputOB.map { $0.count > 5 }
            .drive(btn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        inputOB.asObservable()
            .bind(to: btn.rx.title())
            .disposed(by: disposeBag)
        
        let text = BehaviorRelay(value: "jcc")
        _ = textTF.rx.textInput <-> text
        
        
        btn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            self?.view.backgroundColor = .orange
            print("点击了\(text.value)")
            
        }).disposed(by: disposeBag)
        
    }
    
    
    
}
