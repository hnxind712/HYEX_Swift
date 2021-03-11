//
//  LSAliyunOSSManager.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import Foundation
import DryAliyunOSS_iOS


let AliyunEndPoint = "https://oss-cn-shenzhen.aliyuncs.com";
let AliyunAccessKey = "LTAI4Fni8NjLwUgjLNM7qevA";
let AliyunSecretKey = "0qZgTl1kCQQHgTiAd3WrcKFA61Ek9M";

class LSAliyunOSSManager {
    func uploadImage(data image:Data) {
        DryAliyunOSS.initClient(withEndPoint: AliyunEndPoint, delegate: self, config: nil)
    }
}
extension LSAliyunOSSManager: DryAliyunOSSDelegate{
    func aliyunOSSToken(_ resp: @escaping (String?, String?, String?, String?) -> Void) {
        resp(AliyunAccessKey,AliyunSecretKey,nil,nil)
    }
}
