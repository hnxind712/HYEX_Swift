//
//  AppDelegate.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainTabbar:LSMainTabbarController = {
        var tabbar = LSMainTabbarController.init()
        
        return tabbar
    }()
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let window = window {
            window.backgroundColor = UIColor.white
        }
        NotificationCenter.default.addObserver(self, selector: #selector(setMainVC), name: Notification.Name(KLoginSuccessNotifyKey), object: nil)
        setMainVC()
        return true
    }
    // MARK: 设置主界面
    @objc private func setMainVC(){
        if LSLoginModel.verifyLogin() {
            window?.rootViewController = mainTabbar
        }else{
            let loginVC = LSLoginViewController()
            loginVC.isShowClose = false
            let nav:LSBaseNavigationController = LSBaseNavigationController.init(rootViewController: loginVC)
            window?.rootViewController = nav
        }
    }
}

