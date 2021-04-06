//
//  Application.swift
//  App
//
//  Created by Flutter on 2021/3/11.
//

import UICore
import Service
private extension Application {

    
    static let mainViewController: JKMainViewController = {
        JKMainViewController(viewControllers:[
            OverviewNavigationController(),
            MineNavigationController(),
            SettingNavigationController(),
        ])
    }()

    static let window: UIWindow = {
        UIWindow(frame: UIScreen.main.bounds)
            .leaf
            .backgroundColor(.white)
            .makeKeyAndVisible()
            .instance
    }()
 
}


public extension Application {
    static func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> UIWindow {
        bootstrap()
        setup()
        return window
    }
}


private extension Application {
    static func bootstrap() {
        
        
        
    }

    static func setup() {
        window.rootViewController = mainViewController
    }
}
