//
//  LSAddWechatAndAlipayVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/17.
//

import UIKit
import CLImagePickerTool
import SwiftyJSON

fileprivate let KUpdatePayUrl = "/bank/update-bank-address"

enum KAddType {
    case wechat,alipay
}
class LSAddWechatAndAlipayVC: LSBaseViewController {

    @IBOutlet weak var realName: UITextField!
    @IBOutlet weak var methodTitle: UILabel!
    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var paymentCode: UIImageView!
    @IBOutlet weak var tradePasswordInput: UITextField!
    private var imageUrl: String = ""
    
    private lazy var imagePicker: CLImagePickerTool = {
        let _imagePicker = CLImagePickerTool()
        _imagePicker.isHiddenVideo = true
        _imagePicker.singleImageChooseType = .singlePicture
        _imagePicker.cameraOut = true
        
        return _imagePicker
    }()
    var type:KAddType = .wechat{
        didSet{
            if type == .alipay {
                methodTitle.text = "支付宝账号".localized
                accountInput.placeholder = "请输入支付宝账号".localized
            }
        }
    }
    private lazy var params:[String : Any] = {
        var para: [String : Any] = [:]
        let bankName: String = type == .alipay ? "支付宝".localized : "微信".localized
        let name: String = type == .alipay ? "支付宝".localized : "微信".localized
        let bankType: Int = type == .alipay ? 1 : 2
        para["bankName"] = bankName
        para["name"] = name
        para["bankType"] = bankType
        para["legalName"] = "CNY"
        para["payPassword"] = tradePasswordInput.text
        para["bankNo"] = accountInput.text
        para["bankUser"] = realName.text
        para["receiptCode"] = imageUrl
        if let model = defultModel{
            para["id"] = model.id
        }
        return para
    }()
    var defultModel: LSPayMethodInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
    }
    private func setupBind(){
        if let model = self.defultModel {
            self.realName.text = model.bankUser
            self.accountInput.text = model.bankNo
            self.title = type == .alipay ? "修改支付宝账号".localized : "修改微信账号".localized
        }else{
            self.title = type == .alipay ? "添加支付宝账号".localized : "添加微信账号".localized
        }
    }
    @IBAction func showSecrutyEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        tradePasswordInput.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func savePaymentAction(_ sender: UIButton) {
        guard realName.text!.count > 0 else {
            self.view.makeToast("请输入真实姓名".localized)
            return
        }
        
        guard accountInput.text!.count > 0 else {
            let message: String = type == .alipay ? "请输入支付宝账号".localized : "请输入微信账户".localized
            self.view.makeToast(message)
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
//                LSLoginModel.getUserInfo()
            }else{
                self.view.makeToast(json["errorMessage"].string)
            }
        } failure: { (error) in
            sender.isEnabled = true
            self.view.makeToast(error.localizedDescription)
        }

    }
    // MARK: 选择图片
    @IBAction func selectPaymentCodeAction(_ sender: UIButton) {
        imagePicker.cl_setupImagePickerWith(MaxImagesCount: 1) { (asset, image) in
            LSAliyunOSSManager.shared.uploadImage(with: image!) { (url) in
                self.imageUrl = url;
                self.paymentCode.image = image
            }
        }
    }
}
