//
//  LSIBInspectable.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/23.
//

import UIKit


extension UIView {
    // MARK: 圆角
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    // MARK: 边框颜色
    @IBInspectable var borderColor: UIColor {
        
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor;
        }
    }
    // MARK: 边框宽度
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue;
        }
    }

    // MARK: 根据圆角，以及对应位置切圆角
    func viewCornerRadius(_ radius: CGSize,_ roundingCorners: UIRectCorner) {
        let filPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: radius)
        let filLayer = CAShapeLayer()
        filLayer.frame = bounds
        filLayer.path = filPath.cgPath
        layer.mask = filLayer
    }
    // MARK: 定义渐变颜色枚举
    enum GradientDirection:Int {
        case TopToBottom = 0,LeftToRight,LeftTopToRightBottom,LeftBottomToRightTop
    }
    func viewGradient(with colors: [CGColor],gradient: GradientDirection = .LeftToRight) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint.zero
        
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.colors = colors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
