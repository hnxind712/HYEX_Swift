//
//  AppDelegate.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit
import SwiftyJSON

let KVersionUpdateUrl = "/app-version"
let KLogoutUrl = "/user/logout"

enum KRootType {
    case main,login
}
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
    
    // MARK: 重新设置界面
    func resetAppRoot(with type: KRootType) {
        if type == .login {
            self.logout {
                let loginVC = LSLoginViewController()
                loginVC.isShowClose = false
                let nav:LSBaseNavigationController = LSBaseNavigationController.init(rootViewController: loginVC)
                self.window?.rootViewController = nav
            }
        }else{
            window?.rootViewController = mainTabbar
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
    // MARK: 修改登录密码之后需要重新登录,暂时保留回调，理论上只需要切换root
    func logout(_ sucess:(()->())? = nil) {
        LSNetRequest.sharedInstance.getRequest(KLogoutUrl) { (response) in
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                UserDefaults.standard.removeObject(forKey: KUserInfoKey)
                UserDefaults.standard.removeObject(forKey: KLoginModelKey)
                UserDefaults.standard.synchronize()
                sucess?()
            }else{
                self.window?.makeToast(json["errorMessage"].string)
            }
        }
    }
}
