//
//  LSLoginViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/20.
//

import UIKit
import Toast_Swift
import SwiftyJSON

class LSLoginViewController: LSBaseViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var accountInput: UITextField!//用户名
    @IBOutlet weak var passwordInput: UITextField!//密码
    @IBOutlet weak var verifyCodeInput: UIView!//验证码
    var isShowClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeBtn.isHidden = !isShowClose
        
        testFunc()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func testFunc() {
        LSNetRequest.sharedInstance.getRequest(KBaseUrl + "/pc" , params: ["coinName":"ETH","settlementCurrency":"USDT"]) { (response) in
            if let dic = response as? Dictionary<String, Any>{
                let json = dic["content"]
                print(json!)
//                let data = try? JSONSerialization.data(withJSONObject: json, options: [])
//                print(data!)
//                let decode = JSONDecoder()
                let list = test1(json, [TestModel].self)
                    //try! decode.decode([TestModel].self, from: data!)
                print(list)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(list.first), forKey: "lists")
                sleep(2)
                
                
                print("*******************")
                
                if let data = UserDefaults.standard.value(forKey: "lists") as? Data{
                    let lists  = try? PropertyListDecoder().decode(TestModel.self,from:data)
                    print(lists!)
                }
            }
            
        } failure: { (error) in
            
        }

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
