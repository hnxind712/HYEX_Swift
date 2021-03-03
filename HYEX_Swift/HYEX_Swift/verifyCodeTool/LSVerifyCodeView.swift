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
    func show(_ params:[String:Any]) {
        let view = UIApplication.shared.keyWindow
        view?.addSubview(self)
        self.frame = view!.bounds
        //显示的时候每次刷新一下图形验证码
        _params = params
        LSNetRequest.sharedInstance.downloadGraphVerifyRequest(KBaseUrl + KGraphValidateCode, params: params) { (progress) in
            
        } success: { (response) in
            let url:URL = response as! URL
            self.imageCode.image = UIImage.init(contentsOfFile:url.absoluteString)
        } failure: { (error) in
            
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        removeFromSuperview()
    }
    var verifyBlock:(()->())?
    @IBAction func sendVerifyCodeAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let block = verifyBlock {
            block()
        }
    }
    // MARK: 切换图形验证码
    @IBAction func switchImageCodeAction(_ sender: UIButton) {
        LSNetRequest.sharedInstance.downloadGraphVerifyRequest(KBaseUrl + KGraphValidateCode, params: _params!) { (progress) in
            
        } success: { (response) in
            
        } failure: { (error) in
            
        }
    }
    // MARK: 刷新图形验证码
    @IBAction func refreshImageCodeAction(_ sender: UIButton) {
    }
}