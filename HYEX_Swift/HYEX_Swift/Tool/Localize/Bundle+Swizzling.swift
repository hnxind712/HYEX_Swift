//
//  Bundle+Swizzling.swift
//
//  Created by natai on 2020/4/7.
//  
//  Copyright © 2020 bibr. All rights reserved.
//
    

import Foundation

extension Bundle {
    @objc static func swizzlingLocalize() {
        _ = self.swizzleMethod
    }
    
    @objc func bibr_localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        // 只有主 bundle 才去寻找当前语言 bundle，当前语言 bundle 直接返回国际化字符串
        guard self == Bundle.main else {
            return bibr_localizedString(forKey: key, value: value, table: tableName)
        }
        if let path = path(forResource: Localize.currentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else if let path = path(forResource: LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {    // 主 bundle 若没有当前语言 bundle，则直接调用自身的国际化
            return bibr_localizedString(forKey: key, value: value, table: tableName)
        }
    }
    
    private static let swizzleMethod: Void = {
        let original = #selector(localizedString(forKey:value:table:))
        let swizzled = #selector(bibr_localizedString(forKey:value:table:))
        swizzlingForClass(Bundle.self, originalSelector: original, swizzledSelector: swizzled)
    }()
}
