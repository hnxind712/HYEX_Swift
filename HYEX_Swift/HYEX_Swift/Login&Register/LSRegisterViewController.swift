//
//  LSRegisterViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import UIKit

let KRegisterUrl: String = "/user/register_login"//注册

class LSRegisterViewController: LSBaseViewController {
    enum KRegitserType: Int {
        case phone = 1,email
    }
    
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var codeLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var verifyInput: UITextField!
    @IBOutlet weak var verifyBtn: LSVerifyCodeBtn!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var payPassword: UITextField!
    @IBOutlet weak var inviteCodeInput: UITextField!
    
    var areaCode: String = KBasicAreaCode//默认
    var registerType: KRegitserType = .phone//默认手机注册

    // MARK: 验证码弹窗
    lazy var verifyCodeView:LSVerifyCodeView = {
        let codeView = LSVerifyCodeView.verifyCodeView()
        codeView?.verifyBlock = {(code) in
            var params: [String : Any] = [:]
            params["areaCode"] = self.areaCode
            params["phone"] = self.accountInput
            params["type"] = "REGISTER"
            params["captchaImgCode"] = code
            self.verifyBtn.sendMessageVerifyCodeAction(params)
        }
        return codeView!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: 获取验证码
    @IBAction func getMessageVerifyCodeAction(_ sender: LSVerifyCodeBtn) {
        guard self.accountInput.text?.count != 0 else {
            self.view.makeToast("请输入手机号/邮箱".localized)
            return
        }
        verifyCodeView.show(["areaCode":"86"])
    }
    @IBAction func exchangeRegisterType(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected {
            phoneBtn.setTitle("手机注册".localized, for: .normal)
            emailBtn.setTitle("邮箱注册".localized, for: .normal)
            codeBtn.isHidden = false
            codeLeftConstraint.constant = 65
            remarkLabel.text = "手机号".localized
            registerType = .phone
            accountInput.placeholder = "请输入手机号".localized
        }else{
            phoneBtn.setTitle("邮箱注册".localized, for: .normal)
            emailBtn.setTitle("手机注册".localized, for: .normal)
            codeBtn.isHidden = true
            codeLeftConstraint.constant = 0
            remarkLabel.text = "邮箱".localized
            registerType = .email
            accountInput.placeholder = "请输入邮箱".localized
        }
    }
    // MARK: 注册
    @IBAction func registerAction(_ sender: UIButton) {
        var params:[String:Any] = [:]
        params["areaCode"] = areaCode
        if registerType == .phone {
            params["mobile"] = accountInput.text
        }else{
            params["email"] = accountInput.text
        }
        params["password"] = passwordInput.text
        params["payPassword"] = payPassword.text
        params["userName"] = accountInput.text
        params["verificationCode"] = verifyInput.text
        params["invite"] = inviteCodeInput.text
        
        LSNetRequest.sharedInstance.postRequest(KRegisterUrl, params: params) { (response) in
            
        } failure: { (_ error: Error) in
            
        }

    }
    // MARK: 查看用户协议
    @IBAction func checkServiceProtocol(_ sender: UIButton) {
    }
    // MARK: 去登录
    @IBAction func jumpLoginAction(_ sender: UIButton) {
        
    }
    @IBAction func passwprdSecureTextEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            passwordInput.isSecureTextEntry = sender.isSelected
        }else{
            payPassword.isSecureTextEntry = sender.isSelected
        }
    }
}
