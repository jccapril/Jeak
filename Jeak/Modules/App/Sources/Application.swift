//
//  Application.swift
//  App
//
//  Created by Flutter on 2021/3/11.
//

import UICore

private extension Application {
    static let mainViewController: UINavigationController = {
        UINavigationController(rootViewController:ExampleMainViewController())
    }()

    static let window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        return window
    }()
 
}


public extension Application {
    static func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> UIWindow {
        bootstrap()
        setup()
        
        window.makeKeyAndVisible()
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
