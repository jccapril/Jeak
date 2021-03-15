//
//  ExampleMainViewController.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore

class ExampleMainViewController: ViewController {

    let reuserId = "ExampleMainViewControllerCell"
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.backgroundColor = .white
        lazy.register(UITableViewCell.self, forCellReuseIdentifier: reuserId)
        return lazy
    }()

}

// MARK: - Override

extension ExampleMainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        bindDataSource()
        logic()
    }
    
}

// MARK: - Private

private extension ExampleMainViewController {
    
    
    /// UI
    func setup() {
        
        self.title = "Example"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
        
    func bindDataSource(){
        
        let items = Observable.just(ExampleViewModel().examples)
        items
            .bind(to: tableView.rx.items(cellIdentifier: reuserId, cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.title
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
    }
    
    func logic(){
    
        
        tableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
                
                if(indexPath.row == 0) {
                    self.navigationController?.pushViewController(CodableExampleViewController(), animated: true)
                }else if(indexPath.row == 1) {
                    self.navigationController?.pushViewController(EquatableExampleViewController(), animated: true)
                }else if(indexPath.row == 2) {
                    self.navigationController?.pushViewController(TableViewWithCommandsExampleViewController(), animated: true)
                }else if(indexPath.row == 3) {
                    self.navigationController?.pushViewController(RxSwiftExampleViewController(), animated: true)
                }else if(indexPath.row == 4) {
                    self.navigationController?.pushViewController(RxSwiftFilteringViewController(), animated: true)
                }else if(indexPath.row == 5) {
                    self.navigationController?.pushViewController(RxSwiftSubjectViewController(), animated: true)
                }else if(indexPath.row == 6) {
                    self.navigationController?.pushViewController(RxSwiftUIViewController(), animated: true)
                }

            })
            .disposed(by: disposeBag)

    }
    
}


struct ExampleModel {
    let title:String
    let target:String
}

struct ExampleViewModel {
    var examples = Array<ExampleModel>()
    init() {
        examples.append(ExampleModel(title:"Codable", target: "CodableExampleViewController"))
        examples.append(ExampleModel(title:"Equatable", target: "EquatableExampleViewController"))
        examples.append(ExampleModel(title:"TableViewWithCommands", target: "TableViewWithCommandsExampleViewController"))
        examples.append(ExampleModel(title:"RxSwift-Observable", target: "RxSwiftExampleViewController"))
        examples.append(ExampleModel(title:"RxSwift-Filtering", target: "RxSwiftFilteringViewController"))
        examples.append(ExampleModel(title:"RxSwift-Subject", target: "RxSwiftSubjectViewController"))
        examples.append(ExampleModel(title: "RxSwift-UI", target: "RxSwiftUIViewController"))
    }
}
