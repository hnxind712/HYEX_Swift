//
//  constantDefine.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import Foundation

#if DEBUG

let KBaseUrl: String = "http://192.168.0.143:8088"

//let KBaseUrl: String = "http://154.91.34.40:8080/api"

#else

let KBaseUrl: String = "http://45.204.12.243/api-test"

#endif


//////////////////////////////////////////其他配置//////////////////////////////////////////
// MARK: toast隐藏的时间
let KHideDelay: TimeInterval = 1

// MARK: 区域号
let KBasicAreaCode = "86"

// MARK: 登录成功后缓存LoginModel对应的key
let KLoginModelKey = "KLoginModelKey"
let KUserInfoKey = "KUserInfoKey"
let KLoginSuccessNotifyKey = "KLoginSuccessNotifyKey"



//////////////////////////////////////////URL相关//////////////////////////////////////////
// MARK: 图形验证码
let KGraphValidateCode = "/user/word.jpg"

// MARK: 短信验证码
let KMessageValidateCode = "/user/verify-code"

// MARK: 登录
let KLoginUrl = "/user/login"

// MARK: 获取用户信息
let KUserInfoUrl = "/user/user-info"

