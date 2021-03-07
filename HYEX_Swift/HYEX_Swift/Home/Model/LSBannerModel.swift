//
//  LSBannerModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import Foundation
struct  LSBannerModel: Codable{
    /**
     "clientType": 0,
     "content": "string",
     "createTime": "2020-03-23T03:02:49.451Z",
     "endTime": "string",
     "id": 0,
     "lastTime": "2020-03-23T03:02:49.451Z",
     "link": "string",
     "locale": "string",
     "name": "string",
     "position": "string",
     "startTime": "string",
     "status": "SHOW",
     "type": "LINK",
     "url": "string"
     */
    
    let clientType: Int32?
    
    let content: String?
    
    let createTime: String?
    
    let endTime: String?
    
    let id: Int32?
    
    let lastTime: String?
    
    let link: String?
    
    let locale: String?
    
    let name: String?
    
    let position: String?
    
    let startTime: String?
    
    let status: String?
    
    let type: String?
    
    let url: String?
    
}
