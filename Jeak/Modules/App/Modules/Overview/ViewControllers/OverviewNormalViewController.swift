//
//  OverviewNormalViewController.swift
//  App
//
//  Created by Flutter on 2021/4/15.
//

import UICore

class OverviewNormalViewController: ViewController {
    
    
    
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


extension OverviewNormalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
      
    }
    
}


private extension OverviewNormalViewController {
    func setupUI(){
        self.banner.leaf.add(to: self.view)
    }
}



// MARK: - Delegate
// MARK: - CarouseViewDelegate

extension OverviewNormalViewController:CarouseViewDelegate {
    
    func carouseView(_ carouseView: CarouseView, toCurrentPageIndex index: Int) {
        print("toCurrentPageIndex:\(index)")
    }
    
    func carouseView(_ carouseView: CarouseView, didSelectItemAtIndex index: Int) {
        print("didSelectItemAtIndex:\(index)")
    }
    
}
