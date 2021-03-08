//
//  LSOTCTradeUserInfo.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/8.
//

import Foundation
struct LSOTCTradeUserInfo:Codable {
    /*
    "approvedAt": "2020-10-20T03:15:00.354Z",
    "bankName": "string",
    "bankNo": "string",
    "bankType": "BANK",
    "bankUser": "string",
    "createdAt": "2020-10-20T03:15:00.354Z",
    "email": "string",
    "id": 0,
    "name": "string",
    "phone": "string",
    "photoUrl": "string",
    "reason": "string",
    "status": 0,
    "type": 0,
    "updatedAt": "2020-10-20T03:15:00.354Z",
    "userId": 0,
    "videoUrl": "string",
    "workingStatus": 0
     */
    let approvedAt: String?
    
    let bankName: String?
    
    let bankNo: String?
    
    let bankType: String?
    
    let bankUser: String?
    
    let createdAt: String?
    
    let email: String?
    
    let id: Int32?
    
    let name: String?
    
    let phone: String?
    
    let photoUrl: String?
    
    let reason: String?
    
    let status: Int32?
    
    let type: Int32?
    
    let updatedAt: String?
    
    let userId: Int32?
    
    let videoUrl: String?
    
    let workingStatus: Int32?
    
}
