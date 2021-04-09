//
//  TabBar.swift
//  App
//
//  Created by Flutter on 2021/4/7.
//

import UICore

protocol TabBarDelegate: NSObjectProtocol {
    func tabBar(_ tabBar: TabBar, didClickCenterButton button:UIButton)
}

class TabBar: UITabBar {
        
    weak var jkDelegate: TabBarDelegate?
    lazy var centerButton: UIButton = {
        UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            .leaf
            .image(TabBarItemModular.image(named: "ic_tabbar_item_mine"), for: .normal)
            .shadow(color: Theme.tabbarItemSelectedColor, offset: CGSize(width: 0, height: 5), opacity: 0.8, radius: 3.0)
            .instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabbarOptions()
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
    
    // MARK: - 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            
            /// 判断是否为根控制器
            if self.isHidden {
                /// tabbar隐藏 不在主页 系统处理
                return super.hitTest(point, with: event)
                
            }else{
                /// 将单钱触摸点转换到按钮上生成新的点
                let onButton = self.convert(point, to: self.centerButton)
                /// 判断新的点是否在按钮上
                if self.centerButton.point(inside: onButton, with: event){
                    return centerButton
                }else{
                    /// 不在按钮上 系统处理
                    return super.hitTest(point, with: event)
                }
            }
        }
}

private extension TabBar {
    
    func setupTabbarOptions() {
        self.isTranslucent = false
        self.barTintColor = Theme.backgroundColor
        self.tintColor = Theme.tabbarItemSelectedColor
        self.unselectedItemTintColor = Theme.tabbarItemUnSelectedColor
        self.backgroundImage = UIImage(color: Theme.tabbarBackgroundColor,size: CGSize(width: UIScreen.main.bounds.width, height: Adaptor.tabBarHeight)).withRoundedCorners(radius: 30)
        self.shadowImage = UIImage()
    }
    
    func setupUI() {
        centerButton.leaf.add(to: self)
        centerButton.addTarget(self, action: #selector(respondsToCenterButton(btn:)), for: .touchUpInside)
    }
    
    @objc
    func respondsToCenterButton(btn:UIButton) {
        if jkDelegate != nil {
            jkDelegate?.tabBar(self, didClickCenterButton: btn)
        }
    }
}
