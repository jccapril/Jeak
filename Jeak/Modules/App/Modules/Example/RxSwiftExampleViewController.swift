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

enum RxSwiftObservableMethod {
    case Create
    case Just
    case Of
    case From
    case Never
    case Empty
    case Error
    case Range
    
    var value:String {
        switch self {
        case .Create:
            return "create"
        case .Just:
            return "just"
        case .Of:
            return "of"
        case .From:
            return "from"
        case .Never:
            return "never"
        case .Empty:
            return "empty"
        case .Error:
            return "error"
        case .Range:
            return "range"
            
        }
    }
}


enum MyError:Error {
    case A
    case B
    var errorType:String {
        switch self {
        case .A:
            return "i am error A"
        case .B:
            return "BBBB"
        }
    }
}


class RxSwiftExampleViewController: ViewController {
    
    var dataSource = [RxSwiftObservableMethod]()
    
    
    let reuserId = "ExampleMainViewControllerCell"
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.delegate = self
        lazy.dataSource = self
        lazy.backgroundColor = .white
        lazy.register(UITableViewCell.self, forCellReuseIdentifier: reuserId)
        return lazy
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "RxSwift-Observable"
        
        dataSource = [RxSwiftObservableMethod.Create,RxSwiftObservableMethod.Just,
                      RxSwiftObservableMethod.Of,RxSwiftObservableMethod.From,
                      RxSwiftObservableMethod.Never,RxSwiftObservableMethod.Empty,
                      RxSwiftObservableMethod.Error,RxSwiftObservableMethod.Range]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        //该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）。
//        Observable.repeatElement("jcc").subscribe { (event) in
//            print(event)
//        }.disposed(by: disposeBag)
        
        
        //该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
        //第一个参数:初始化的数值  第二个 条件  第三也是一个条件 0 + 2 <= 10 依次循环下去,iterate:重复执行
        Observable.generate(initialState: 0, condition: {$0<=10}, iterate: {$0+2})
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        //上面和下面的效果一样
        Observable.of(0,2,4,6,8,10).subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        
        //该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
        var isOdd = true
        let factory:Observable<Int> = Observable.deferred { () -> Observable<Int> in
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7,9)
            }else {
                return Observable.of(2,4,6,8,10)
            }
        }
        
        factory.subscribe{(event) in
            print(event)
        }.disposed(by: disposeBag)
        
        factory.subscribe{(event) in
            print(event)
        }.disposed(by: disposeBag)
        
        
        //这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
//        Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe{ (event) in
//                print(event)
//            }
//            .disposed(by: disposeBag)
        
//        Observable<Int>.timer(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe{ (event) in
//                print(event)
//            }
//            .disposed(by: disposeBag)
        
        //另一种是创建的 Observable 延迟一段时间后，每隔一段时间产生一个元素。
        Observable<Int>.timer(RxTimeInterval.seconds(5), period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        
        
        
        
    }
    
    

}

extension RxSwiftExampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserId, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = dataSource[indexPath.row].value
        
        return cell
    }
    
}


extension RxSwiftExampleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let value = dataSource[indexPath.row]
        print("click \(value)")
        
        switch value {
        case .Create:
            
            //通过指定的方法实现来自定义一个被观察的序列。
            //订阅创建
            let myOb = Observable<Any>.create { (observ) -> Disposable in
                observ.onNext("jcc")
                observ.onCompleted()
                return Disposables.create()
            }
            
            //订阅事件
            myOb.subscribe { (even) in
                    print(even)
                }
                .disposed(by: disposeBag)//销毁
            
            break
        
        case .Just:
            //该方法通过传入一个默认值来初始化。
            Observable.just("jcc")
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
            
        case .Of:
            // 该方法可以接受可变数量的参数（必需要是同类型的）
            Observable.of("o","f","of")
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
        
        case .From:
            //该方法需要一个数组参数。
            Observable.from(["f","r","o","m"])
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
        
        case .Never:
            //该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
            Observable<Int>.never()
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
        
        case .Empty:
            //该方法创建一个空内容的 Observable 序列。 //会打印complete
            Observable<Int>.empty()
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
        
        case .Error:
            //该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
            let myError = MyError.A
            print(myError.errorType)
            Observable<Int>.error(myError)
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
            
        case .Range:
            //该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。
            Observable.range(start: 1, count: 6)
                .subscribe { (event) in
                    print(event)
                }
                .disposed(by: disposeBag)
            break
            
        }
        
        
    }
    
}
