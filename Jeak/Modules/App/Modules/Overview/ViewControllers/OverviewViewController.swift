//
//  OverviewViewController.swift
//  App
//
//  Created by Flutter on 2021/4/6.
//

import UICore

class OverviewViewController: ViewController {
    
    lazy var banner: CarouseView = {
       
        let lazy = CarouseView(frame: CGRect(x: 0, y: Adaptor.navibarHeight + 20, width: self.view.frame.size.width, height: 200), shouldInfiniteLoop: true, types:[.ssq,.dlt])
        lazy.isZoom = true
        lazy.imgCornerRadius = 40
        lazy.itemWidth = self.view.frame.size.width - 100
        lazy.pageControl.isHidden = true;
        lazy.delegate = self
        return lazy
        
    }()

}


// MARK: - Override

extension OverviewViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNaviagtionBar()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    


    
    
}


// MARK: - Method

private extension OverviewViewController {
    
    
    func setupNaviagtionBar() {
    
//        let label1 = UIBarButtonItem(title: "我的", style: .plain, target: nil, action: nil)
//        let label2 = UIBarButtonItem(title: "彩票", style: .plain, target: nil, action: nil)
        
        let left = NaviagtionBarModular.localizedString(key: "NaviagtionBar.Item.Overview.Title.Left")
        let right = NaviagtionBarModular.localizedString(key: "NaviagtionBar.Item.Overview.Title.Right")
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let abs = NSMutableAttributedString(string: "\(left)  \(right)")
        
        abs.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: NSRange(location: 0, length: left.count))
        abs.addAttribute(.font, value: UIFont.systemFont(ofSize: 30, weight: .thin), range: NSRange(location: left.count + 2, length: right.count))
        label.attributedText = abs
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        
    }
    
    func setupUI(){
        self.banner.leaf.add(to: self.view)
    }
    
}


// MARK: - Delegate
// MARK: - CarouseViewDelegate

extension OverviewViewController:CarouseViewDelegate {
    
    func carouseView(_ carouseView: CarouseView, toCurrentPageIndex index: Int) {
        print("toCurrentPageIndex:\(index)")
    }
    
    func carouseView(_ carouseView: CarouseView, didSelectItemAtIndex index: Int) {
        print("didSelectItemAtIndex:\(index)")
    }
    
}
