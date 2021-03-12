//
//  File.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore


class TableViewWithCommandsExampleViewController: ViewController {

    let reuserId = "TableViewWithCommandsExampleViewControllerCell"
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.backgroundColor = .white
        lazy.register(UITableViewCell.self, forCellReuseIdentifier: reuserId)
        return lazy
    }()
}



// MARK: - Override

extension TableViewWithCommandsExampleViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
//        let loadFavoriteUsers: () = RandomUserAPI.sharedAPI
//            .getExampleUserResultSet()
//            .subscribe(onNext: { result in
//                print(result)
//            })
//            .disposed(by: disposeBag)
        
//        print(loadFavoriteUsers)
        
        
    }
    
}

// MARK: - Private

private extension TableViewWithCommandsExampleViewController {
    
    /// UI
    func setup() {
        
        self.title = "TableViewWithCommands"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
}






struct User: Equatable, CustomDebugStringConvertible{

    var firstName: String
    var lastName: String
    var imageURL: String
    
}

extension User {
    var debugDescription: String {
        firstName + " " + lastName
    }
}
