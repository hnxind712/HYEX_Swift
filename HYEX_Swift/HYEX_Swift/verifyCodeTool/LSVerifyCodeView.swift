//
//  LSVerifyCodeView.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/24.
//

import UIKit

class LSVerifyCodeView: UIView {

    @IBOutlet weak var imageCodeView: UIView!//图形验证码
    @IBOutlet weak var sliderView: UIView!//滑块验证码
    @IBOutlet weak var verifyInput: UITextField!
    @IBOutlet weak var imageCode: UIImageView!//展示图形验证码
    var _params:[String:Any]?
    
    class func verifyCodeView() -> LSVerifyCodeView? {
        let view = Bundle.main.loadNibNamed("LSVerifyCodeView", owner: nil, options: nil)
        if let codeview = view?.first as? LSVerifyCodeView {
            return codeview
        }
        return nil
    }
    func show(_ params:[String:Any]? = nil) {
        let view = UIApplication.shared.keyWindow
        view?.addSubview(self)
        self.frame = view!.bounds
        //显示的时候每次刷新一下图形验证码
        _params = params
        showGraphverifyCode()
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        removeFromSuperview()
    }
    var verifyBlock:((_ code: String)->())?
    @IBAction func sendVerifyCodeAction(_ sender: UIButton) {
        guard self.verifyInput.text?.count != 0 else {
            self.makeToast("请输入验证码".localized)
            return
        }
        self.removeFromSuperview()
        if let block = verifyBlock {
            block(self.verifyInput.text!)
        }
    }
    // MARK: 切换图形验证码
    @IBAction func switchImageCodeAction(_ sender: UIButton) {
        
    }
    // MARK: 刷新图形验证码
    @IBAction func refreshImageCodeAction(_ sender: UIButton) {
        showGraphverifyCode()
    }
    func showGraphverifyCode() {
        LSNetRequest.sharedInstance.downloadGraphVerifyRequest(KGraphValidateCode, params: _params) { (progress) in
            
        } success: { (response) in
            self.imageCode.image = UIImage(data: response as! Data)
        } failure: { (error) in
            
        }
    }
}
