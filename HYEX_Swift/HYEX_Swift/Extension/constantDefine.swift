//
//  constantDefine.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import Foundation

#if DEBUG

let KBaseUrl: String = "http://154.91.34.40:8080/api"

#else

let KBaseUrl: String = "http://45.204.12.243/api-test"

#endif

// MARK: 图形验证码
let KGraphValidateCode = "/user/word.jpg"

// MARK: 短信验证码
let KMessageValidateCode = "/user/verify-code"

