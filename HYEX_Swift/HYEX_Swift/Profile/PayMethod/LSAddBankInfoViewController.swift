//
//  LSAddBankInfoViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/17.
//

import UIKit
import SwiftyJSON

fileprivate let KUpdatePayUrl = "/bank/update-bank-address"

class LSAddBankInfoViewController: LSBaseViewController {

    @IBOutlet weak var realNameInput: UITextField!
    @IBOutlet weak var bankNameInput: UITextField!
    @IBOutlet weak var bankBranchInput: UITextField!
    @IBOutlet weak var bankCardInput: UITextField!
    @IBOutlet weak var tradePasswordInput: UITextField!
    private lazy var params: [String : Any] = {
        var para: [String : Any] = [:]
        para["bankName"] = bankNameInput.text
        para["bankNo"] = bankCardInput.text
        para["bankType"] = 0
        para["name"] = bankBranchInput.text
        para["payPassword"] = tradePasswordInput.text
        para["legalName"] = "CNY"
        para["bankUser"] = realNameInput.text
        if let model = defultModel {
            para["id"] = model.id
        }
        return para
    }()
    var defultModel: LSPayMethodInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBind()
    }
    private func setupBind() {
        if let model = defultModel {
            realNameInput.text = model.bankUser
            bankNameInput.text = model.bankName
            bankBranchInput.text = model.name
            bankCardInput.text = model.bankNo
            self.title = "修改银行卡".localized
        }else{
            self.title = "添加银行卡".localized
        }
    }
    @IBAction func setPasswordSecrutyEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tradePasswordInput.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func saveAction(_ sender: UIButton) {
        guard realNameInput.text!.count > 0 else {
            self.view.makeToast("请输入真实姓名".localized)
            return
        }
        guard bankNameInput.text!.count > 0 else {
            self.view.makeToast("请输入开户银行".localized)
            return
        }
        guard bankBranchInput.text!.count > 0 else {
            self.view.makeToast("请输入开户支行".localized)
            return
        }
        guard bankCardInput.text!.count > 0 else {
            self.view.makeToast("请输入银行卡号".localized)
            return
        }
        guard tradePasswordInput.text!.count > 0 else {
            self.view.makeToast("请输入交易密码".localized)
            return
        }
        print(params)
        sender.isEnabled = false
        LSNetRequest.sharedInstance.postRequest(KUpdatePayUrl, params: params) { (response) in
            sender.isEnabled = true
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                if let _ = self.defultModel {
                    self.view.makeToast("修改成功".localized)
                }else{
                    self.view.makeToast("添加成功".localized)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                self.view.makeToast(json["errorMessage"].string)
            }
        } failure: { (error) in
            sender.isEnabled = true
            self.view.makeToast(error.localizedDescription)
        }
    }
}
