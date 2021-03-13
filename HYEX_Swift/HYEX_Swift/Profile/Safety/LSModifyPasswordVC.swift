//
//  LSModifyPasswordVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/13.
//

import UIKit
import SwiftyJSON

enum KResetType {//修改类型
    case login,trade
}
let KResetLoginPwdUrl = "/user/reset-pwd"
let KResetTradePwdUrl = "/user/reset-pay-pwd"

class LSModifyPasswordVC: LSBaseViewController {

    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var verifyCode: UITextField!
    @IBOutlet weak var verifyBtn: LSVerifyCodeBtn!
    
    fileprivate var areaCode: String = "86"
    var resetType: KResetType = .login
    
    fileprivate lazy var url: String = {
        return self.resetType == .login ? KResetLoginPwdUrl : KResetTradePwdUrl
    }()
    
    fileprivate lazy var phone: String = {
        if let mobile = LSUserInfo.sharedInstance()?.mobile{
            return mobile
        }else{
            return (LSUserInfo.sharedInstance()?.email)!
        }
    }()
    
    // MARK: 验证码弹窗
    lazy var verifyCodeView:LSVerifyCodeView = {
        let codeView = LSVerifyCodeView.verifyCodeView()
        codeView?.verifyBlock = {(code) in
            var params: [String : Any] = [:]
            params["type"] = "TRANSACTION_FORGET"
            params["captchaImgCode"] = code
            params["phone"] = self.phone
            if let areaCode = LSUserInfo.sharedInstance()?.areaCode{
                self.areaCode = areaCode
                params["areaCode"] = areaCode
            }else{
                params["areaCode"] = "86"
            }
            self.verifyBtn.sendMessageVerifyCodeAction(params)
        }
        return codeView!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = resetType == .login ? "登录密码".localized : "交易密码".localized
    }
    @IBAction func getVerifyCodeAction(_ sender: LSVerifyCodeBtn) {
        verifyCodeView.show(["areaCode":"86"])
    }
    @IBAction func submitAction(_ sender: Any) {
        guard newpassword.text!.count > 0 else {
            self.view.makeToast("请输入新密码".localized)
            return
        }
        guard confirmPassword.text!.count > 0 else {
            self.view.makeToast("请再次输入新密码".localized)
            return
        }
        guard newpassword.text! != confirmPassword.text! else {
            self.view.makeToast("两次输入的密码不一致".localized)
            return
        }
        guard verifyCode.text!.count > 0 else {
            self.view.makeToast("请输入验证码".localized)
            return
        }
        let key: String = resetType == .login ? "password" : "payPassword"
        
        let params: [String : Any] = ["areaCode" : areaCode,
                                      key : confirmPassword.text,
                                      "phone" : phone,
                                      "verificationCode":verifyCode.text
        ]
        LSNetRequest.sharedInstance.postRequest(url, params: params) { (response) in
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                self.view.makeToast("修改成功".localized)
                if self.resetType == .login {//需要重新登录
                    AppDelegate.shared.resetAppRoot(with: .login)
                }
            }
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }

        
    }
}
