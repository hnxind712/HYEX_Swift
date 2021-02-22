//
//  NSObject+Extension.swift
//
//  Created by natai on 2018/6/8.
//  Copyright © 2018年 Natai. All rights reserved.
//

import Foundation

extension NSObject {
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(forClass, originalSelector),
              let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else {
            return
        }
        
        let isAddSuccess = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if isAddSuccess {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
