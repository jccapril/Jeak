//
//  MainViewController.swift
//  App
//
//  Created by 蒋晨成 on 2021/3/11.
//

import UICore

// https://www.jianshu.com/p/eeba45a94137
class MainViewController: ViewController {
    
    let reuserId = "cell"
    
    
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.register(UITableViewCell.self, forCellReuseIdentifier: reuserId)
        return lazy
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let items = Observable.just(InfoViewModel().arr)
        
        
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: reuserId, cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.nameStr
                
            }
            .disposed(by: disposeBag)
    
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.setSelected(false, animated: true)
                print("选中项的indexPath为：\(indexPath)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(DataModel.self)
            .subscribe(onNext: { (model) in
                print("点击了 \(model.despStr) :\(model.nameStr)" )
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
                    .subscribe(onNext: { (indexPath) in
                        print("删除 \(indexPath)")
                    })
                    .disposed(by: disposeBag)

    }
    
    func setup(){
        
    }
    
}


struct DataModel {
    let despStr:String
    let nameStr:String
}

struct InfoViewModel {
    var arr = Array<DataModel>()
    
    init(){
        arr.append(DataModel(despStr: "first", nameStr: "Cooci"))
        arr.append(DataModel(despStr: "2", nameStr: "Gavin"))
        arr.append(DataModel(despStr: "3", nameStr: "James"))
        arr.append(DataModel(despStr: "4", nameStr: "Dean"))
        arr.append(DataModel(despStr: "5", nameStr: "Kody"))
    }

}
