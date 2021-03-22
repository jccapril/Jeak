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
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.separatorStyle = .none
        lazy.backgroundColor = .white
        lazy.register(Reusable.cell)
        lazy.register(Reusable.headerView)
        return lazy
    }()
    
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
        
    }
    
}
