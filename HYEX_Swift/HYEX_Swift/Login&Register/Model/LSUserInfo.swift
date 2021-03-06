//
//  LSUserInfo.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import Foundation
struct LSUserInfo: Codable {
    
    let areaCode: String?    //国家代码
    
    let autoWithdraw: Int32? //是否允许提现的时候自动审核 0: 不允许 1:允许 2: 未限制
    
    let bindBank: Bool? //是否绑定收款码
    
    let bindPaypwd: Bool?    //是否绑定支付密码
    
    let email: String?   //邮箱
    
    let googleAuth: Int32?   //是否关联了谷歌验证器 0:未关联 1:已关键
    
    let groupName: String?   //组名
    
    let groupType: String?   //用户分组
    
    let id: Int32?   //用户ID
    
    let idCard: String?  //实名验证的证件号码
    
    let idCardImg1: String?  //实名验证的图片1
    
    let idCardImg2: String?  //实名验证的图片2
    
    let idCardImg3: String?  //实名验证的图片3
    
    let idCardInfo: String?  //当前实名验证的一些额外备注信息，比如验证失败原因
    
    let idCardStatus: Int32? //图片实名验证的状态，0，未实名验证，1，等待身份证验证，2：身份证号码验证通过
    
    let idCardTime: String?  //图片实名验证时间
    
    let idCardType: Int32?   //实名验证的证件类型，0是默认表示没有认真，1表示中国居民身份证，2是国际护照
    
    let inviteCode: String?  //邀请码
    
    let isPublishOtc: Int32? //是否有发布OTC权限，1有，其他没有
    
    let lastLoginIp: String? //最近一次登录的用户ip
    
    let lastLogInt32ime: String? //最后一次登录时间
    
    let leverageType: Int32? //杠杆用户类型，0表示正常用户，1表示是用户的杠杆账号
    
    let loginTimes: Int32?   //用户登录次数
    
    let mobile: String?  //用户绑定的手机号码
    
    let otcProfile: otcProfile?  //otc配置
    
    let realName: String?    //用户真实姓名
    
    let realNameStatus: Int32?   //实名验证状态，0，未实名验证，1，等待身份证验证，2：身份证号码验证通过
    
    let referrer: Int32? //推荐人id
    
    let referrerCount: Int32?    //推荐人数
    
    let referrerKYCCount: Int32? //推荐人中已经通过KYC的数量
    
    let referrerMobile: String?  //推荐人电话
    
    let referrerReward: Double?  //推荐奖励总和
    
    let referrerRewardAll: Double?   //推荐奖励所有包括未认证的
    
    let referrerUrl: String? //推荐码
    
    let registerIp: String?  //注册时的ip
    
    let registerTime: String?    //注册时间
    
    let status: Int32?   //用户状态，0：正常，1：被禁用, 2 未激活 3： 未绑定(遗留账号）
    
    let updateTime: String?  //最后一次用户修改资料的时间，登录不修改这个时间
    
    let userName: String?    //用户登录名称，全表唯一
    
    let userPrivilege: Int32?    //是否特权用户，0表示不是，1是特权用户
    
    let userType: Int32? //用户类型0，正常用户，1：超级节点
    
    
    struct otcProfile: Codable{
        
        let areaCode: String?
        
        let createdAt: String?
        
        let id: Int32?
        
        let mobile: String?
        
        let userId: Int32?
        
    }
    
    static func sharedInstance() -> LSUserInfo?{
        return instance
    }
    private static var instance: LSUserInfo? = {
        if let data = UserDefaults.standard.value(forKey: KUserInfoKey) as? Data{
            if let model: LSUserInfo = try? PropertyListDecoder().decode(LSUserInfo.self, from: data){
                return model
            }
        }
        return nil
    }()
}
