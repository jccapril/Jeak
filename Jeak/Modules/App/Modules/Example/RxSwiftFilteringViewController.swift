//
//  RxSwiftFilteringViewController.swift
//  App
//
//  Created by Flutter on 2021/3/15.
//

import UICore


class RxSwiftFilteringViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "RxSwift-Filtering"
        
//        testFilter()
//        testDistinctUntilChanged()
//        testSingle()
//        testElementAt()
//        testIgnoreElements()
//        testTake()
//        testTakeLast()
//        testSkip()
//        testSample()
//        testDebounce()
//        testGroupBy()
//        testConcatMap()
//        testFlatMap()
//        testMap()
        testBuffer()
        testWindow()
    }
    

    func testFilter(){
        //该操作符就是用来过滤掉某些不符合要求的事件。
        Observable.of(2,30,22,5,60,70)
            .filter{
                $0 > 10
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
    }

    
    func testDistinctUntilChanged(){
        //该操作符用于过滤掉连续重复的事件。
        Observable.of(2,2,30,2,22,22,10,50,10,60)
            .distinctUntilChanged()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func testSingle(){
        Observable.of(2,30,22,5,60,70)
            .single()
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func testElementAt(){
        // 只发送你选定的那个元素
        Observable.of(2,30,22,5,60,70)
            .element(at: 2)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func testIgnoreElements(){
        
//        该操作符可以忽略掉所有的元素，只发出 error或completed 事件。
//        如果我们并不关心 Observable 的任何元素，只想知道 Observable 在什么时候终止，那就可以使用 ignoreElements 操作符。
        Observable.of(2,30,22,5,60,70)
            .ignoreElements()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func testTake(){
        //  该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
        Observable.of(2,30,22,5,60,70)
            .take(1)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func testTakeLast(){
        //   该方法实现仅发送 Observable序列中的后 n 个事件。
        Observable.of(1, 2, 3, 4)
            .takeLast(2)
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
    func testSkip(){
        //   跳过源 Observable 序列发出的前 n 个事件。
        Observable.of(1, 2, 3, 4)
            .skip(2)
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
    
    func testSample(){
        //  通过 notifier 的事件 - 会触发  source 的响应，而如果两次 notifier 事件之间没有源序列的事件，则不发送值。
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        source.sample(notifier)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        source.onNext(1)
        notifier.onNext("A")
        source.onNext(2)
        notifier.onNext("B")
        notifier.onNext("C")
        source.onNext(3)
        source.onNext(4)
        notifier.onNext("D")
        source.onNext(5)
        notifier.onCompleted()
    }
    
    
    func testDebounce(){
        
        //        debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。
        //        换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。
        //        debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
        
        //定义好每个事件里的值以及发送的时间
        let times = [ [ "value": 1, "time": 100 ],
                      [ "value": 2, "time": 1100 ],
                      [ "value": 3, "time": 1200 ],
                      [ "value": 4, "time": 1200 ],
                      [ "value": 5, "time": 1400 ],
                      [ "value": 6, "time": 2100 ], ]
        
      
        
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(RxTimeInterval.milliseconds(Int(item["time"]!)), scheduler: MainScheduler.instance)
            }
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
                
    }
    
    
    func testGroupBy(){
        Observable<Int>.of(1,2,3,4,5,6,7,8,9)
            .groupBy(keySelector: { (element) -> String in
                return element % 2 == 0 ? "偶数" : "奇数"
            })
            .subscribe { (event) in
                switch event {
                case .next(let group):
                    group.asObservable()
                        .subscribe ({ (event) in
                            print("event==\(event): \n key = \(group.key)")
                        })
                        .disposed(by: self.disposeBag)
                case .completed:
                    print("完成")
                case .error(let myError):
                    print(myError)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    func testConcatMap(){
        
        /**
         concatMap 与 flatMap 的唯一区别是：当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素。或者说等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅
         */
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        let relay = BehaviorRelay(value: subject1)
        relay.asObservable()
            .concatMap{ $0 }
            .subscribe(onNext:{ print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        relay.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        
        subject1.onCompleted()
        
        /**
         A
         B
         C
         2
         为什么没有打印1 因为在储存订阅的时候,发现1没有订阅,结果被2替换了储存,之后订阅,就能打印了
        */

        
    }
    
    
    func testFlatMap(){
//        map 在做转换的时候容易出现“升维”的情况。即转变之后，从一个序列变成了一个序列的序列。
//        而 flatMap 操作符会对源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。即又将其 "拍扁"（降维）成一个 Observable 序列。
//        这个操作符是非常有用的。比如当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来。
      
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        let variable = BehaviorRelay(value: subject1) //这里装进去1
        variable.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        //这样12都能打印
   
    }
    
    func testMap(){
    
        //该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。
        let subject = PublishSubject<String>()
        subject.map { (str) -> String in
            return str+"hello"
            }
            .subscribe(onNext: { (event) in
                print(event)
            }, onError: nil, onCompleted: {
                print("完成了")
            }) {
                print("销毁了")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("Cooci")
        
    }
    
    
    func testWindow(){
    
//        window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
//        同时 buffer要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
        
        let subject = PublishSubject<String>()
        subject.window(timeSpan: RxTimeInterval.seconds(2), count: 2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (event) in
                print(event)
            }, onError: nil, onCompleted: {
                print("完成了")
            }) {
                print("销毁了")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        
        
        
    }
    
    
    func testBuffer(){
        let subject = PublishSubject<String>()
        subject.buffer(timeSpan: RxTimeInterval.seconds(2), count: 2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            } onError: { (error) in
                print(error)
            } onCompleted: {
                print("完成")
            } onDisposed: {
                print("销毁")
            }
            .disposed(by: disposeBag)
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")

        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        

    }
    
}
