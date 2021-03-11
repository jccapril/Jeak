//
//  AppDelegate.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
import enum UICore.Application
import App
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        defer { window = Application.application(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }


}

