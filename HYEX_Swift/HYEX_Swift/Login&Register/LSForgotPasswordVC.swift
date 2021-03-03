//
//  LSForgotPasswordVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/24.
//

import UIKit

class LSForgotPasswordVC: LSBaseViewController {

    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var verifyCodeBtn: UIButton!
    @IBOutlet weak var verifyCodeInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      }
  // MARK: 获取验证码
  // MARK: 设置密码是否明文
    @IBAction func setPasswordSecureTextEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            passwordInput.isSecureTextEntry = sender.isSelected
        }else{
            confirmPasswordInput.isSecureTextEntry = sender.isSelected
        }
    }
}
