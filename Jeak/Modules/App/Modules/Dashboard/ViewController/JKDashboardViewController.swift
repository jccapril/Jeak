//
//  DashboardViewController.swift
//  App
//
//  Created by Flutter on 2021/3/16.
//

import UICore

class JKDashboardViewController: ViewController {

    private enum Reusable {
        static let cell = ReusableCell<JKLotteryRankTableViewCell>()
        static let headerView = ReusableView<JKCurrentLotteryHeaderView>()
    }
    lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .backgroundColor(.white)
            .register(Reusable.cell)
            .register(Reusable.headerView)
            .instance
    }()
    
    public var lotteryType: JKLotteryType = .ssq
    
}

// MARK: - Override

extension JKDashboardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        

    }
}



private extension JKDashboardViewController {
    
    func setupUI() {
        
        tableView.leaf.add(to: view).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
