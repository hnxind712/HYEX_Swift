//
//  LSFeedBackViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import UIKit
import CLImagePickerTool
import SwiftyJSON

let KMaxTextInput = 200

let KFeedBackURL = "/user/feeback"

class LSFeedBackViewController: LSBaseViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placehoud: UILabel!
    
    var imageUrl: String = ""//提交的图片地址
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func setupLayout(){
        let btn = view.viewWithTag(10) as! UIButton
        
        btn.viewGradient(with: [HEXCOLOR(h: 0x3685F9, alpha: 1).cgColor,HEXCOLOR(h: 0x5E2CEF, alpha: 1).cgColor])
    }
    // MARK: 添加图片
    @IBAction func addFeedbackPictureAction(_ sender: UIButton) {
        let imagePicker = CLImagePickerTool()
        imagePicker.isHiddenVideo = true
        imagePicker.singleImageChooseType = .singlePicture
        imagePicker.cameraOut = true
        imagePicker.cl_setupImagePickerWith(MaxImagesCount: 1) { (asset, image) in
            LSAliyunOSSManager.shared.uploadImage(with: image!) { (url) in
                print(url)
                self.imageUrl = url
                sender.setBackgroundImage(image, for: .normal)
            }
        }
    }
    
    // MARK: 提交反馈
    @IBAction func submitFeedbackAction(_ sender: UIButton) {
        self.view.endEditing(true)
        guard textView.text.count > 0 else {
            self.view.makeToast("请描述您的问题".localized)
            return
        }
        LSNetRequest.sharedInstance.postRequest(KFeedBackURL, params: ["message":textView.text as! String,"image":imageUrl]) { (response) in
             let data = JSON(response)
            if data["statusCode"].int == 0{
                self.view.makeToast("提交成功".localized)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.makeToast(data["errorMessage"].string)
            }
            
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }
    }
}
extension LSFeedBackViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count <= 0 {
            self.placehoud.isHidden = false
        }else{
            self.placehoud.isHidden = true
        }
        self.countLabel.text = "\(textView.text.count)/\(KMaxTextInput)"
    }
}
