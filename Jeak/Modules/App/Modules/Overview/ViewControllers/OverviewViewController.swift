//
//  OverviewViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class OverviewViewController: ViewController {
    
    private enum OverviewMode: Int {
        case normal = 0
        case simple = 1
    }
    private var mode: OverviewMode = .simple
    private lazy var childrenControllers:[ViewController] = {
        let normal = OverviewNormalViewController()
        let simple = OverviewSimpleViewController()
        simple.delegate = self
        return [normal,simple]
    }()
    
    private var currentController:ViewController?
}


// MARK: - Override

extension OverviewViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNaviagtionBar()
        setupChildrenControllers()
//        setupUI()
    }
    
}


// MARK: - Method

private extension OverviewViewController {
    
    
    func setupNaviagtionBar() {
    
        let left = NaviagtionBarModular.localizedString(key: "NaviagtionBar.Item.Overview.Title.Left")
        let right = NaviagtionBarModular.localizedString(key: "NaviagtionBar.Item.Overview.Title.Right")
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let abs = NSMutableAttributedString(string: "\(left)  \(right)")
        
        abs.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: NSRange(location: 0, length: left.count))
        abs.addAttribute(.font, value: UIFont.systemFont(ofSize: 30, weight: .thin), range: NSRange(location: left.count + 2, length: right.count))
        label.attributedText = abs
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: NaviagtionBarModular.image(named: "ic_naviagtion_item_switch"), style: .plain, target: self, action: #selector(switchMode(sender:)))
        
    }
    
    func setupChildrenControllers(){
        if mode == .normal {
            currentController = childrenControllers[0]
        }else {
            currentController = childrenControllers[1]
        }
        
        view.addSubview(currentController!.view)
    }
    
    @objc
    func switchMode(sender:UIBarButtonItem) {
        currentController!.view.isHidden = true
        if mode == .normal {
            mode = .simple
            currentController = childrenControllers[1]
        }else {
            mode = .normal
            currentController = childrenControllers[0]
        }
        guard currentController!.isViewLoaded else {
            view.addSubview(currentController!.view)
            return
        }
        currentController!.view.isHidden = false


    }
    
}

extension OverviewViewController: OverviewSimpleViewControllerDelegate {
    func viewControllerDidSelectedType(type: Int64) {
        let list = OverviewListViewController(type: type)
        list.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(list, animated: true)
    }
}
