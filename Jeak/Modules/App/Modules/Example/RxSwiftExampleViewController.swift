//
//  RxSwiftExampleViewController.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore


/**
 
 RxSwift 文档
 https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
 
 https://www.jianshu.com/p/eeba45a94137
 */


class RxSwiftExampleViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        //通过指定的方法实现来自定义一个被观察的序列。
        //订阅创建
        let myOb = Observable<Any>.create { (observ) -> Disposable in
            observ.onNext("cooci")
            observ.onCompleted()
            return Disposables.create()
        }
        
        //订阅事件
        myOb.subscribe { (even) in
                print(even)
            }
            .disposed(by: disposeBag)//销毁
        
        //该方法通过传入一个默认值来初始化。
        Observable.just("jcc")
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        // 该方法可以接受可变数量的参数（必需要是同类型的）
        Observable.of("o","f","of").subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        //该方法需要一个数组参数。
        Observable.from(["f","r","o","m"]).subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        
    }
    
    

}
