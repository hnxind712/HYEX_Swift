//
//  LSFeedBackModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import Foundation
struct LSFeedBackModel: Codable {
    /**
     @property (nonatomic, copy) NSString *createTime;
     @property (nonatomic, copy) NSString *image;
     @property (nonatomic, copy) NSString *message;
     @property (nonatomic, copy) NSString *responseMessage;
     @property (nonatomic, copy) NSString *userName;
     @property (nonatomic, assign) NSInteger fid;
     @property (nonatomic, assign) NSInteger userId;
     */
    var createTime: String?
    
    var image: String?
    
    var message: String?
    
    var responseMessage:String?
    
    var userName: String?
    
    var fid: Int32?
    
    var userId: Int32?
}
