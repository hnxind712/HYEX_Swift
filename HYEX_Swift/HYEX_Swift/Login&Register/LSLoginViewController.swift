//
//  LSLoginViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/20.
//

import UIKit
import Toast_Swift
import SwiftyJSON
import Kingfisher

class LSLoginViewController: LSBaseViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var accountInput: UITextField!//用户名
    @IBOutlet weak var passwordInput: UITextField!//密码
    @IBOutlet weak var verifyCodeInput: UITextField!//验证码
    @IBOutlet weak var imageCode: UIImageView!
    var isShowClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeBtn.isHidden = !isShowClose
        
        // MARK: 获取图形验证码
        getGraphCode()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func getGraphCode() {
        LSNetRequest.sharedInstance.downloadGraphVerifyRequest(KGraphValidateCode, params: ["areaCode":KBasicAreaCode]) { (progrss) in
            
        } success: { (response) in
            self.imageCode.image = UIImage(data: response as! Data)
        } failure: { (error) in
            
        }

    }
    // MARK: refreshGraphCode
    @IBAction func refreshGraphCodeAction(_ sender: UIButton) {
        getGraphCode()
    }
    
    // MARK: - 忘记密码
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let forgorPassword = LSForgotPasswordVC()
        self.navigationController?.pushViewController(forgorPassword, animated: true)
    }
    // MARK: - 去注册
    @IBAction func jumpToRegisterAction(_ sender: UIButton) {
        let registerVC: LSRegisterViewController = LSRegisterViewController.init()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    // MARK: - 是否显示密码
    @IBAction func showPasswordAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordInput.isSecureTextEntry = !sender.isSelected
    }
    // MARK: - 登录
    @IBAction func loginAction(_ sender: UIButton) {
        var style:ToastStyle = .init()
        style.messageColor = HEXCOLOR(h: 0x877889, alpha: 1)
        
        guard self.accountInput.text!.count > 0 else {
            view.makeToast("请输入用户名".localized, duration: KHideDelay, position: .center, title: nil, image: nil, style: style, completion: nil)
            return
        }
        guard self.passwordInput.text!.count > 0 else {
            view.makeToast("请输入密码".localized, duration: KHideDelay, position: .center, title: nil, image: nil, style: style, completion: nil)
            return
        }
        guard self.verifyCodeInput.text!.count > 0 else {
            view.makeToast("请输入验证码".localized, duration: KHideDelay, position: .center, title: nil, image: nil, style: style, completion: nil)
            return
        }
        // MARK: 登录
        LSNetRequest.sharedInstance.postRequest(KLoginUrl, params: ["userName":accountInput.text!,"password":passwordInput.text!,"captchaImgCode":verifyCodeInput.text!]) { (response) in
            print(response)
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                if let jsonDic = response as? Dictionary<String, Any>{
                    let model: LSLoginModel = decodeJsonToModel(json: jsonDic["content"], ele: LSLoginModel.self)!
                    print(model)
                    //请求个人数据，并缓存到本地
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(model), forKey: KLoginModelKey)
                    
                    LSLoginModel.getUserInfo(true)
                }
            }else{
                self.view.makeToast(json["errorMessage"].string)
            }
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }
    }
    // MARK: - 关闭界面
    @IBAction func closeAction(_ sender: UIButton) {
    }
    
    // MARK: - 设置语言
    @IBAction func setLanguageAction(_ sender: Any) {
        print((LSUserInfo.sharedInstance()?.areaCode)! as String)
    }
}
