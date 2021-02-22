//
//  LSLoginViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/20.
//

import UIKit
import Toast_Swift

class LSLoginViewController: LSBaseViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var accountInput: UITextField!//用户名
    @IBOutlet weak var passwordInput: UITextField!//密码
    @IBOutlet weak var verifyCodeInput: UIView!//验证码
    var isShowClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeBtn.isHidden = !isShowClose
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    // MARK: - 忘记密码
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
    }
    // MARK: - 去注册
    @IBAction func jumpToRegisterAction(_ sender: UIButton) {
        let registerVC: LSRegisterViewController = LSRegisterViewController.init()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    // MARK: - 是否显示密码
    @IBAction func showPasswordAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    // MARK: - 登录
    @IBAction func loginAction(_ sender: UIButton) {
        var style:ToastStyle = .init()
        style.messageColor = HEXCOLOR(h: 0x877889, alpha: 1)
        
        guard self.accountInput.text!.count > 0 else {
            view.makeToast("请输入用户名", duration: 1, position: .center, title: nil, image: nil, style: style, completion: nil)
            return
        }
    }
    // MARK: - 关闭界面
    @IBAction func closeAction(_ sender: UIButton) {
    }
    
    // MARK: - 设置语言
    @IBAction func setLanguageAction(_ sender: Any) {
    }
}
