//
//  NavigationController.swift
//  UICore
//
//  Created by Flutter on 2021/4/7.
//
import Foundation
import UIKit

open class NavigationController: UINavigationController {
    override private init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }

    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        pushViewController(rootViewController, animated: false)
    }

    override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Override

extension NavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    override open var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    override open var childForStatusBarHidden: UIViewController? {
        topViewController
    }

    override open var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}

// MARK: - Private

private extension NavigationController {
    func setup() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool { viewControllers.count > 1 }
}

// MARK: - Assert

extension NavigationController {
    @available(*, unavailable)
    override open func setNavigationBarHidden(_: Bool, animated _: Bool) {
        fatalError("DO NOT CALL THIS")
    }

    // swiftlint:disable unused_setter_value
    override open var isNavigationBarHidden: Bool {
        get { super.isNavigationBarHidden }
        set { fatalError("DO NOT CALL THIS") }
    }
}
