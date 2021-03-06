//
//  LSNoticeListModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import Foundation
struct LSNoticeListModel: Codable {
    /*
     "content": "string",
     "createTime": "2020-03-18T07:26:52.587Z",
     "creatorName": "string",
     "displayTime": "2020-03-18T07:26:52.587Z",
     "id": 0,
     "locale": "string",
     "sort": 0,
     "status": "SHOW",
     "title": "string",
     "titleEn": "string",
     "type": "NOTICE",
     "updatedAt": "2020-03-18T07:26:52.587Z"
     */
    let content: String?
    
    let createTime: String?
    
    let creatorName: String?
    
    let displayTime: String?
    
    let id: Int32
    
    let locale: String?
    
    let sort: Int32
    
    let status: String?
    
    let title: String?
    
    let titleEn: String?
    
    let type: String?
    
    let updatedAt: String?
    
}
