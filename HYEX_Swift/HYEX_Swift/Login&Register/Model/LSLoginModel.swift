//
//  LSLoginModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import Foundation
struct LSLoginModel: Codable {
    
    // MARK: 绑卡
    let bindBank: Bool?
    
    // MARK: 绑定邮箱
    let bindEmail: Bool?
    
    // MARK: 绑定谷歌密码
    let bindGoogleSecret: Bool?
    
    // MARK: 绑定手机
    let bindMobile: Bool?
    
    // MARK: 绑定交易密码
    let bindPaypwd: Bool?
    
    // MARK: c1认证是否通过
    let c1Authenticated: Bool?
    
    // MARK: c2认证是否通过
    let c2Authenticated: Bool?
    
    // MARK: 是否实名
    let realNameAuth: Bool?
    
    let userId: Int32?
    
    let userName: String?
    
    let token: String?
    
    // MARK: 创建初始化方法
    static func sharedInstace()->LSLoginModel{
        return instance!
    }
    private static var instance:LSLoginModel? = {
        if let data = UserDefaults.standard.value(forKey: "lists") as? Data{
            let model: LSLoginModel  = try! PropertyListDecoder().decode(LSLoginModel.self,from:data)
            return model
        }
        return nil
    }()
    
    // MARK: 验证登录状态
    static func verifyLogin() -> Bool {
        if let data = UserDefaults.standard.value(forKey: KLoginModelKey) as? Data{
            let model: LSLoginModel  = try! PropertyListDecoder().decode(LSLoginModel.self,from:data)
            print(model)
            let status = model.token!.count > 0 ? true : false
            return status
        }
        return false
    }
    
    // MARK: 获取用户信息
    static func getUserInfo() {
        LSNetRequest.sharedInstance.getRequest(KUserInfoUrl, params: nil) { (response) in
            print(response)
            
            if let jsonData = response as? Dictionary<String, Any>{
                if let userInfo = decodeJsonToModel(json: jsonData["content"] as Any, ele: LSUserInfo.self){
                    print(userInfo)
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo.self), forKey: KUserInfoKey)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: KLoginSuccessNotifyKey), object: nil)//发送通知
                }
            }
        } failure: { (error) in
            
        }
    }
}
