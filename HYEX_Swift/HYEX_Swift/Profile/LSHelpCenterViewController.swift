//
//  LSHelpCenterViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit
import WebKit
import SwiftyJSON

let KPrivacyUrl = "/article/type"

enum KHtmlLoadType {
    //@"STAKING_AGREEMENT"->矿池协议
    //@"AGREEMENT"->注册协议x
    //@"PRIVACY"->版本更新隐私协议
    //@"MERCHANT"->商户协议
    case staking,register,privacy,merchant
}
class LSHelpCenterViewController: LSBaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var type: KHtmlLoadType = .privacy//默认为隐私协议
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHtml()
    }
    func loadHtml(){
        LSNetRequest.sharedInstance.getRequest(KPrivacyUrl, params: ["type" : typeString(with: type),"locale" : "zh_CN"]) { (response) in
            let data = JSON(response)
            if data["statusCode"].int == 0 {
                let content: String = data["content"]["content"].string!
                let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>"
                let fitStr = String(format: "%@<head><style>img{width:%f !important;height:auto}</style></head>%@",headerString,kScreen_width, content)
                self.title = data["content"]["title"].string!
                self.webView .loadHTMLString(fitStr, baseURL: nil)
            }
        } failure: { (error) in
            
        }
    }
    // MARK: 根据type取类型
    func typeString(with type: KHtmlLoadType) -> String {
        let typeDic: [KHtmlLoadType : String] = [.merchant : "MERCHANT",
                                                 .privacy  : "PRIVACY",
                                                 .register : "AGREEMENT",
                                                 .staking  : "STAKING_AGREEMENT"]
        return typeDic[type]!
    }
}
