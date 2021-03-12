//
//  AppDelegate.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit
import SwiftyJSON

let KVersionUpdateUrl = "/app-version"

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainTabbar:LSMainTabbarController = {
        var tabbar = LSMainTabbarController.init()
        return tabbar
    }()
    class var shared: AppDelegate {
        struct instance{
            static let _instance: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        }
        return instance._instance
    }


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
extension AppDelegate{
    func updateVersion() {
        LSNetRequest.sharedInstance.getRequest(KVersionUpdateUrl, params: ["platform" : "ios"]) { (response) in
            let data = JSON(response)
            if data["statusCode"].int == 0 {
                let localVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
                let versionStr = data["content"]["versionName"].string
                
                if localVersion != versionStr {
                    DispatchQueue.main.async {
                        //弹窗
                        LSCustomAlertView.alert(title: "提示".localized, message: "检测到新版本，请更新".localized, cancleTitle: "取消".localized, confirmTitle: "更新".localized, cancleHandle: nil) {
                            if let downloadUrl = data["content"]["downloadUrl"].string{
                                if UIApplication.shared.canOpenURL(URL(string: downloadUrl)!){
                                    UIApplication.shared.open(URL(string: downloadUrl)!, options: [:], completionHandler: nil)
                                }
                            }
                        }
                    }
                }
            }
        } failure: { (error) in
            
        }
    }
    
}
