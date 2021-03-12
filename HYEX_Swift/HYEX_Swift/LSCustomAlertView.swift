//
//  LSCustomAlertView.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit

class LSCustomAlertView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    

    private var confirm: (()->())?
    
    private var cancle: (()->())?
    
    class func alert(title t: String?, message: String?, cancleTitle: String? = "取消".localized, confirmTitle: String? = "确认".localized, cancleHandle:(()->())? = nil, confirmHandle: (()->())? = nil) {
        let view = Bundle.main.loadNibNamed(String(describing: LSCustomAlertView.self), owner: nil, options: nil)
        if let _view = view?.first as? LSCustomAlertView {
            
            _view.cancle = cancleHandle
            _view.confirm = confirmHandle
            
            _view.cancleBtn.setTitle(cancleTitle, for: .normal)
            _view.cancleBtn.setTitle(cancleTitle, for: .highlighted)
            
            _view.confirmBtn.setTitle(confirmTitle, for: .normal)
            _view.confirmBtn.setTitle(confirmTitle, for: .highlighted)
            
            _view.title.text = t
            _view.content.text = message
            
            UIApplication.shared.keyWindow?.addSubview(_view)
            _view.frame = UIApplication.shared.keyWindow!.bounds
        }
    }
    @IBAction func cancleAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let _cancle = cancle {
            _cancle()
        }
    }
    @IBAction func confirmAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if let _confirm = confirm {
            _confirm()
        }
    }
}
