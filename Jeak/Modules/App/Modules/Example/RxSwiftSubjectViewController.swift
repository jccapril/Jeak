//
//  RxSwiftSubjectViewController.swift
//  App
//
//  Created by 蒋晨成 on 2021/3/15.
//

import UICore

class RxSwiftSubjectViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "RxSwift-Subject"
        
//        testPublishSubject()
        
//        testBehaviorRelay()
        
//        testReplaySubject()
        
        testBehaviorSubject()
        
    }
    
    
    
    
    func testReplaySubject() {
        // 缓存2个
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        subject.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        subject.onNext("ddd")
        
        subject.onCompleted()
        
        subject.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    func testBehaviorSubject() {
        
        
        // 必须设置默认值，订阅会接受前一个
        let subject = BehaviorSubject(value: "jcc")
        subject.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        subject.onNext("aa")
        
        
        subject.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        subject.onError(NSError(domain: "myError", code: 10086, userInfo: ["myuserinfo":"10086"]))
        
        subject.onCompleted()
    }
    
    func testBehaviorRelay() {
        
        // BehaviorSubject的封装 通过accept改成值来发送订阅
        let subject = BehaviorRelay(value: "aaa")
        subject.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        subject.accept("bbbb")
    
        

    }
    
    func testPublishSubject(){
    
        let subject = PublishSubject<String>()
        subject.onNext("aa")
        
        subject.subscribe { (event) in
            print(event)
        } onError: { (err) in
            print(err)
        } onCompleted: {
            print("完成")
        } onDisposed: {
            print("销毁")
        }.disposed(by: disposeBag)

        subject.onNext("bb")
        subject.onCompleted()
        
        subject.subscribe { (event) in
            print(event)
        } onError: { (err) in
            print(err)
        } onCompleted: {
            print("完成")
        } onDisposed: {
            print("销毁")
        }.disposed(by: disposeBag)
        
        
    }
    



}
