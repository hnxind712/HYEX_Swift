//
//  LSForgotPasswordVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/24.
//

import UIKit
import SwiftyJSON

let KResetPasswordUrl = "/user/reset-pwd"

class LSForgotPasswordVC: LSBaseViewController {

    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var verifyCodeBtn: UIButton!
    @IBOutlet weak var verifyCodeInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var verifyBtn: LSVerifyCodeBtn!
    
    // MARK: 验证码弹窗
    lazy var verifyCodeView:LSVerifyCodeView = {
        let codeView = LSVerifyCodeView.verifyCodeView()
        codeView?.verifyBlock = {(code) in
            var params: [String : Any] = [:]
            params["phone"] = self.accountInput
            params["type"] = "PASSWORD_FORGET"
            params["captchaImgCode"] = code
            self.verifyBtn.sendMessageVerifyCodeAction(params)
        }
        return codeView!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
      }
  // MARK: 获取验证码
    @IBAction func getVerifyCodeAction(_ sender: LSVerifyCodeBtn) {
        guard self.accountInput.text?.count != 0 else {
            self.view.makeToast("请输入手机号/邮箱".localized)
            return
        }
        verifyCodeView.show()
    }
    // MARK: 设置密码是否明文
    @IBAction func setPasswordSecureTextEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            passwordInput.isSecureTextEntry = sender.isSelected
        }else{
            confirmPasswordInput.isSecureTextEntry = sender.isSelected
        }
    }
    @IBAction func confirmAction(_ sender: UIButton) {
        self.view.endEditing(true)
        guard self.verifyCodeInput.text?.count != 0 else {
            self.view.makeToast("请输入验证码".localized)
            return
        }
        guard self.passwordInput.text?.count != 0 else {
            self.view.makeToast("请输入新密码".localized)
            return
        }
        guard self.confirmPasswordInput.text?.count != 0 else {
            self.view.makeToast("请再次输入密码".localized)
            return
        }
        guard self.passwordInput.text == self.confirmPasswordInput.text else {
            self.view.makeToast("两次输入的密码不一致".localized)
            return
        }
        sender.isEnabled = false
        let params: [String : Any] = ["password" : self.confirmPasswordInput.text,
                                      "phone" : self.accountInput.text,
                                      "verificationCode" : self.verifyCodeInput.text
        ]
        LSNetRequest.sharedInstance.postRequest(KResetPasswordUrl, params: params) { (response) in
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                self.view.makeToast("设置成功".localized)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.makeToast(json["errorMessage"].string)
            }
            sender.isEnabled = true
        } failure: { (error) in
            self.view.makeToast("网络请求失败".localized)
            sender.isEnabled = true
        }

    }
}
