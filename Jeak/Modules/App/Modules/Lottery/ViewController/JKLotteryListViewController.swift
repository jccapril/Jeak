//
//  LotteryListViewController.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import UICore
import Standard

class JKLotteryListViewController: ViewController {
    
    var jkType: JKLotteryType = .ssq
    
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.separatorStyle = .none
        lazy.backgroundColor = .white
        lazy.register(JKLotteryTableViewCell.self, forCellReuseIdentifier: JKLotteryTableViewCell.cellID)
        return lazy
    }()
    
    
    lazy var segment: JKSegmentControl = {
        let lazy = JKSegmentControl(frame: CGRect.zero, items: ["双色球","大乐透"])
        return lazy
    }()
    
}

// MARK: - Override

extension JKLotteryListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        /*
        let viewModel = JKLotteryListViewModel(selectedSegmentIndex: segment.rx.selectedSegmentIndex.asDriver())
        
        viewModel.lotteryType.drive(onNext: { [weak self] type  in
            self?.jkType = type
            print(self?.jkType ?? .ssq)
        }).disposed(by: disposeBag)
 */
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
        
    }
    
    func mockDataSource() -> [JKLottery] {
        var mock = [JKLottery]()
        mock.append(JKLotterySSQ(red: "1,2,3,4,5,6", blue: "1"))
        mock.append(JKLotterySSQ(red: "11,12,13,14,15,16", blue: "2"))
        mock.append(JKLotterySSQ(red: "21,22,23,24,25,26", blue: "3"))
        return mock
    }
    
}
