//
//  LSSafetyViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/10.
//

import UIKit


class LSSafetyViewController: LSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "安全中心".localized
        // Do any additional setup after loading the view.
    }


    // MARK: 修改登录密码
    @IBAction func modifyLoginPasswordAction(_ sender: UITapGestureRecognizer) {
        let trade = LSModifyPasswordVC()
        trade.resetType = .login
        self.navigationController?.pushViewController(trade, animated: true)
    }
    
    // MARK: 修改交易密码
    @IBAction func modifyTradePasswordAction(_ sender: UITapGestureRecognizer) {
        let trade = LSModifyPasswordVC()
        trade.resetType = .trade
        self.navigationController?.pushViewController(trade, animated: true)
    }
    
    // MARK: 退出登录
    @IBAction func exitLoginAction(_ sender: UIButton) {
        let alert = UIAlertController.init(title: nil, message: "是否退出当前账户?".localized, preferredStyle: .alert)
        let exit = UIAlertAction.init(title: "退出".localized, style: .default) { (action) in
            AppDelegate.shared.resetAppRoot(with: .login)
        }
        let cancle = UIAlertAction.init(title: "取消".localized, style: .cancel, handler: nil)
        alert.addAction(exit)
        alert.addAction(cancle)
        self.present(alert, animated: true, completion: nil)
    }

}
