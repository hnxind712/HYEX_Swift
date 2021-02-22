//
//  LSRegisterViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import UIKit

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
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmInput: UITextField!
    @IBOutlet weak var inviteCodeInput: UITextField!
    
    var registerType: KRegitserType = .phone//默认手机注册
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            confirmInput.isSecureTextEntry = sender.isSelected
        }
    }
}
