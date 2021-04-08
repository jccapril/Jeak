//
//  TabBar.swift
//  App
//
//  Created by Flutter on 2021/4/7.
//

import UICore

class TabBar: UITabBar {
    
    lazy var centerButton: UIButton = {
        UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            .leaf
            .image(TabBarItemModular.image(named: "ic_tabbar_item_mine"), for: .normal)
            .instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension TabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerButton.center = CGPoint(x: self.frame.width*0.5, y: 0)
        let w = self.frame.width / 3
        var index = 0
        for childView:UIView in self.subviews {
            if childView.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                childView.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: self.frame.height - Adaptor.safeAreaBottomHeight)

                
                index+=1

                if index == 1{
                    index+=1
                }

            }
//            else if childView.isKind(of: NSClassFromString("_UIBarBackground")!) {
//                childView.isHidden = true
//            }
        }
    }
}

private extension TabBar {
    
    func setupUI() {
        
        self.isTranslucent = false
        self.barTintColor = UIColor(hex: 0xf5f9ff)
        self.backgroundImage = UIImage(color: .white,size: CGSize(width: UIScreen.main.bounds.width, height: Adaptor.tabBarHeight)).withRoundedCorners(radius: 30)
        self.shadowImage = UIImage()
        centerButton.leaf.add(to: self)
        

    }
}
