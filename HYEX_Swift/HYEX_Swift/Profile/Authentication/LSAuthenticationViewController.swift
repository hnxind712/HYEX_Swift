//
//  LSAuthenticationViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit
import CLImagePickerTool
import SwiftyJSON

fileprivate let KAuthenticationUrl = "/user/id-card-auth"

class LSAuthenticationViewController: LSBaseViewController {
    @IBOutlet weak var failView: UIView!
    @IBOutlet weak var failReason: UILabel!
    @IBOutlet weak var topConstriant: NSLayoutConstraint!
    @IBOutlet weak var realNameInput: UITextField!
    @IBOutlet weak var idCardInput: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    lazy var imagePicker: CLImagePickerTool = {
        let _imagePicker = CLImagePickerTool()
        _imagePicker.isHiddenVideo = true
        _imagePicker.singleImageChooseType = .singlePicture
        _imagePicker.cameraOut = true
        
        return _imagePicker
    }()
    
    var positiveUrl = ""
    var reverseUrl = ""
    var holdUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let reason = LSUserInfo.sharedInstance()?.idCardInfo {
            failView.isHidden = false
            topConstriant.constant = 30
            failReason.text = reason
        }
        submitBtn.viewGradient(with: [HEXCOLOR(h: 0x3685F9, alpha: 1).cgColor,HEXCOLOR(h: 0x5E2CEF, alpha: 1).cgColor], gradient: .LeftToRight)
    }
    @IBAction func uploadPositiveAction(_ sender: UIButton) {
        imagePicker.cl_setupImagePickerWith(MaxImagesCount: 1) { (asset, image) in
            LSAliyunOSSManager.shared.uploadImage(with: image!) { (url) in
                self.positiveUrl = url;
                sender.setBackgroundImage(image, for: .normal)
            }
        }
    }
    @IBAction func uploadReverseAction(_ sender: UIButton) {
        imagePicker.cl_setupImagePickerWith(MaxImagesCount: 1) { (asset, image) in
            LSAliyunOSSManager.shared.uploadImage(with: image!) { (url) in
                self.reverseUrl = url;
                sender.setBackgroundImage(image, for: .normal)
            }
        }
    }
    @IBAction func uploadHoldAction(_ sender: UIButton) {
        imagePicker.cl_setupImagePickerWith(MaxImagesCount: 1) { (asset, image) in
            LSAliyunOSSManager.shared.uploadImage(with: image!) { (url) in
                self.holdUrl = url;
                sender.setBackgroundImage(image, for: .normal)
            }
        }
    }

    @IBAction func submitAction(_ sender: UIButton) {
        self.view.endEditing(true)
        guard self.realNameInput.text!.count > 0 else {
            self.view.makeToast("请输入姓名".localized)
            return
        }
        guard self.idCardInput.text!.count > 0 else {
            self.view.makeToast("请输入身份证号码".localized)
            return
        }
        guard self.positiveUrl.count > 0 else {
            self.view.makeToast("请上传身份证正面照".localized)
            return
        }
        guard self.reverseUrl.count > 0 else {
            self.view.makeToast("请上传身份证反面照".localized)
            return
        }
        guard self.holdUrl.count > 0 else {
            self.view.makeToast("请上传手持身份证照".localized)
            return
        }
        sender.isEnabled = false
        
        //配置参数
        var params: [String : String] = ["idcard" : idCardInput.text!,
                                      "idcardType" : "1",
                                      "idcardimg1" : self.positiveUrl,
                                      "idcardimg2" : self.reverseUrl,
                                      "idcardimg3" : self.holdUrl,
                                      "realname" : self.realNameInput.text!,
        ]
        if let areaCode = LSUserInfo.sharedInstance()?.areaCode {
            params["national"] = areaCode
        }else{
            params["national"] = "86"//如果没有默认则为86
        }
        LSNetRequest.sharedInstance.postRequest(KAuthenticationUrl, params: params) { (response) in
            sender.isEnabled = true
            let data = JSON(response)
            if data["statusCode"].int == 0{
                var userInfo = LSUserInfo.sharedInstance()
                userInfo?.realNameStatus = 1 //审核中
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo.self), forKey: KUserInfoKey)
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                self.view.makeToast(data["errorMessage"].string)
            }
        } failure: { (error) in
            sender.isEnabled = true
            self.view.makeToast(error.localizedDescription)
        }

    }
}
