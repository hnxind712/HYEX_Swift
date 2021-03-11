//
//  LSAliyunOSSManager.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import Foundation
import DryAliyunOSS_iOS


let KAliyunEndPoint = "https://oss-cn-shenzhen.aliyuncs.com";
let KAliyunAccessKey = "LTAI4Fni8NjLwUgjLNM7qevA";
let KAliyunSecretKey = "0qZgTl1kCQQHgTiAd3WrcKFA61Ek9M";
let KAliyunBucket = "bbkex"

let KAliyunImageUrl = "https://\(KAliyunBucket).oss-cn-shenzhen.aliyuncs.com/"


class LSAliyunOSSManager {
    class var shared: LSAliyunOSSManager {
        struct instance{
            static let _instance: LSAliyunOSSManager = LSAliyunOSSManager.init()
        }
        return instance._instance
    }
}
extension LSAliyunOSSManager: DryAliyunOSSDelegate{
    func uploadImage(with image:UIImage,completed:@escaping((_ url: String)->())) {
        DryAliyunOSS.initClient(withEndPoint: KAliyunEndPoint, delegate: self, config: nil)
        let objkey = String(format: "%@.jpg", self.objectKeys())
        DryAliyunOSS.uploadImage(withBucket: KAliyunBucket, imageMode: .jpeg, image: image, objectKey: objkey) { (send, total, ex) in
            
        } respError: { (errorCode) in
            UIApplication.shared.keyWindow?.makeToast("上传失败".localized)
        } respSuccess: { (url) in
            completed(KAliyunImageUrl + url)
        }
    }
    func aliyunOSSToken(_ resp: @escaping (String?, String?, String?, String?) -> Void) {
        resp(KAliyunAccessKey,KAliyunSecretKey,"","")
    }
    func objectKeys() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMddhhmmssSSS"
        let objectKey = dateFormatter.string(from: Date())
        return objectKey
    }
}
