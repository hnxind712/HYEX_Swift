//
//  LSAliyunOSSManager.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import Foundation
import DryAliyunOSS_iOS

class LSAliyunOSSManager {
    func uploadImage(data image:Data) {
        DryAliyunOSS.initClient(withEndPoint: "", delegate: self, config: nil)
    }
}
extension LSAliyunOSSManager: DryAliyunOSSDelegate{
    func aliyunOSSToken(_ resp: @escaping (String?, String?, String?, String?) -> Void) {
        
    }
}
