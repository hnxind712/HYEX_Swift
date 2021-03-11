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
//解析json或data为对应的model数据
func decodeDataToModel<T:Decodable>(data : Data?,ele:T.Type) -> T? {
    guard let data = data else { return nil }
    do {
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    } catch  {
        print("Unable to decode", error)
    }
    return nil
}
func decodeJsonToModel<T:Decodable>(json : Any,ele:T.Type) -> T? {
    let _data = try? JSONSerialization.data(withJSONObject: json, options: [])
    guard let data = _data else { return nil }
    do {
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    } catch  {
        print("Unable to decode", error)
    }
    return nil
}
public var kScreen_width: CGFloat{
    return UIScreen.main.bounds.width
}
public var kScreen_height: CGFloat{
    return UIScreen.main.bounds.height
}

extension UIImage{
    // MARK: 定义渐变颜色枚举
    enum GradientDirection:Int {
        case TopToBottom = 0,LeftToRight,LeftTopToRightBottom,LeftBottomToRightTop
    }
    class func gradientImage(size: CGSize,colors color: [UIColor],gradientType type: GradientDirection) -> UIImage {
        var arr:[CGColor] = Array()
        for _color in color {
            arr.append(_color.cgColor)
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        let colorSpace =  arr.last!.colorSpace;
        let gradient = CGGradient(colorsSpace: colorSpace, colors: arr as CFArray, locations: nil)
        
        var startPoint = CGPoint.zero
        
        var endPoint = CGPoint.zero
        
        switch type {
        case .TopToBottom:
            startPoint = CGPoint(x: size.width/2, y: 0)
            endPoint = CGPoint(x: size.width/2, y: size.height)
        case .LeftToRight:
            startPoint = CGPoint(x: 0, y: size.height/2)
            endPoint = CGPoint(x: size.width, y: size.height/2)
        case .LeftTopToRightBottom:
            endPoint = CGPoint(x: size.width, y: size.height)
        case .LeftBottomToRightTop:
            startPoint = CGPoint(x: 0, y: size.height)
            endPoint = CGPoint(x: size.width, y: 0)
        }
        context.drawLinearGradient(gradient!,start: startPoint,end: endPoint,options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

