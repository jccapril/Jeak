//
//  LotteryListViewController.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import UICore
import Standard

//https://github.com/devxoul/ReusableKit

class JKLotteryListViewController: ViewController {
    
    var jkType: JKLotteryType = .ssq
    
    enum Reusable {
        static let lotteryCell = ReusableCell<JKLotteryTableViewCell>()
    }
    
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.separatorStyle = .none
        lazy.backgroundColor = .white
        lazy.register(JKLotteryTableViewCell.self, forCellReuseIdentifier: JKLotteryTableViewCell.cellID)
        return lazy
    }()
    
    
    lazy var segment: JKSegmentControl = {
        let lazy = JKSegmentControl(items: ["双色球","大乐透"])
//        lazy.delegate = self
        return lazy
    }()
    
    lazy var sss: UISegmentedControl = {
        let lazy = UISegmentedControl(items: ["a","b","c"])
        return lazy
    }()
    
}

// MARK: - Override

extension JKLotteryListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        tableView.register(Reusable.lotteryCell)
        
        
        let viewModel = JKLotteryListViewModel(selectedSegmentIndex: segment.rx.selectedIndex.asDriver())
        
        viewModel.lotteryType.drive(onNext: { [weak self] type  in
            self?.jkType = type
            print(self?.jkType ?? .ssq)
        }).disposed(by: disposeBag)
        
        
        view.addSubview(sss)
        sss.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
        }
        sss.rx.controlEvent(.valueChanged).subscribe(onNext: { (event) in
            
            print(event)
            
        }).disposed(by: disposeBag)
        
    }
    
}


private extension JKLotteryListViewController {
    
    
    func setup() {
        
        view.addSubview(segment)
        segment.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.equalTo(50)
            $0.trailing.equalTo(-50)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        

        let btn = UIButton(type: .system)
        btn.setTitle("Test", for: .normal)
        view.addSubview(btn)
        
        btn.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.center.equalToSuperview()
        }
        
        btn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] event in
            if self?.segment.selectedIndex == 1 {
                self?.segment.selectedIndex = 0
            }else {
                self?.segment.selectedIndex = 1
            }
            
            self?.sss.selectedSegmentIndex = 1
            
        }).disposed(by: disposeBag)
        
        
        
        
        
    }
    
    func mockDataSource() -> [Any] {
//        var mock = [JKLottery]()
////        mock.append(JKLotterySSQ(red: "1,2,3,4,5,6", blue: "1"))
////        mock.append(JKLotterySSQ(red: "11,12,13,14,15,16", blue: "2"))
////        mock.append(JKLotterySSQ(red: "21,22,23,24,25,26", blue: "3"))
//        return mock
        return []
    }
    
}

