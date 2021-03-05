//
//  Common.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import Foundation
import UIKit
// MARK: - 颜色
//根据十六进制数生成颜色 HEXCOLOR(h:0xe6e6e6,alpha:0.8)
func HEXCOLOR(h:Int,alpha:CGFloat) ->UIColor {
    return RGBCOLOR(r: CGFloat(((h)>>16) & 0xFF), g:   CGFloat(((h)>>8) & 0xFF), b:  CGFloat((h) & 0xFF),alpha: alpha)
}
//根据R,G,B生成颜色
func RGBCOLOR(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
//随机色
func RANDOMCOLOR() -> UIColor {
    return RGBCOLOR(r: CGFloat(arc4random()%256), g: CGFloat(arc4random()%256), b: CGFloat(arc4random()%256),alpha: 1)
    
}
//如果不需要倒计时处理
func sendMessageVerifyCode(_ params:[String : Any]) {
    LSNetRequest.sharedInstance.postRequest(KBaseUrl + KMessageValidateCode, params: params) { (response) in
        
    } failure: { (error) in
        
    }
}

func test1<T:Codable>(_ json: Any,_ className: T.Type) -> Array<Any> {
    let data = try? JSONSerialization.data(withJSONObject: json, options: [])
    print(data!)
    let decode = JSONDecoder()
    let list = try! decode.decode(className.self, from: data!)
    
    return list as! Array<Any>
}
