//
//  OverviewSimpleViewController.swift
//  App
//
//  Created by Flutter on 2021/4/15.
//

import UICore

class OverviewSimpleViewController: ViewController {
    
    private enum Reusable {
        static let cell = ReusableCell<LotterySimpleTableViewCell>()
    }
    
    lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .plain)
            .leaf
            .separatorStyle(.none)
            .dataSource(self)
            .delegate(self)
            .backgroundColor(Theme.backgroundColor)
            .register(Reusable.cell)
            .instance
    }()
    
    lazy var viewModel = OverviewViewModel()
}

extension OverviewSimpleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        bindRx()
    }
    
}

private extension OverviewSimpleViewController {
    
    func setupUI() {
        
        tableView.leaf.add(to: view)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: Adaptor.navibarHeight, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    
}

private extension OverviewSimpleViewController  {
    func bindRx() {
        viewModel.disposeBag = disposeBag
        bindListView(tableView)
        viewModel.loadFirst()
    }
    
    func bindListView(_ tableView: UITableView) {
        
    }
}

extension OverviewSimpleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LotterySimpleTableViewCell = tableView.dequeue(Reusable.cell, for: indexPath)
        
        
        return cell
    }
    
}


extension OverviewSimpleViewController: UITableViewDelegate {
    
}
