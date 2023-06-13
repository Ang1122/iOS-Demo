//
//  RootViewController.swift
//  MathSolveNow
//
//  Created by 郭宝琪 on 2023/4/11.
//

import Foundation
import UIKit

let kNCWillShowNotification = NSNotification.Name("NCWillShowNotification")

class RootViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .black
        navigationItem.title = ""
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        view.backgroundColor = .clear

        delegate = self
    }

    // MARK: 禁止横屏

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    // MARK: 子view需要重载preferredStatusBarStyle改变状态栏颜色，默认是黑色！

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

extension RootViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            NotificationCenter.default.post(name: kNCWillShowNotification, object: nil, userInfo: ["hidesBottomBarWhenPushed": viewController.hidesBottomBarWhenPushed])
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        NotificationCenter.default.post(name: kNCWillShowNotification, object: nil, userInfo: ["hidesBottomBarWhenPushed": viewController.hidesBottomBarWhenPushed])
    }
}
