//
//  LSPayMethodInfo.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/15.
//

import Foundation

struct LSPayMethodInfo: Codable {
    /**
     bankName = "\U652f\U4ed8\U5b9d";
     bankNo = "\U5b89\U5353\U652f\U4ed8\U5b9d";
     bankType = 1;
     bankUser = "\U5b89\U5353\U5b9e\U540d";
     createTime = "2021-03-12T10:24:42+0800";
     id = 7;
     lastTime = "2021-03-12T10:25:41+0800";
     legalName = CNY;
     name = "";
     receiptCode = "https://bbkex.oss-cn-shenzhen.aliyuncs.com/6f398155a9a3c053fb778eccc8188ac81615515952013.jpg";
     status = 1;
     userId = 33;
     */
    let bankName: String
    
    let bankNo: String
    
    let bankType: Int32
    
    let bankUser: String
    
    let createTime: String
    
    let name: String
    
    let receiptCode: String
    
    let status: Int32
    
    let userId: Int32
}
