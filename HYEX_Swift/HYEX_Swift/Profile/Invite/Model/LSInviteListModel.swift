//
//  LSInviteListModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import Foundation
struct LSInviteListModel: Codable {

    let directInvitations: Int32?   //直接邀请人数（直推总人数）
    
    let directValidInvitations: Int32?  //直接邀请有效人数（有过投资的人数）
    
    let email: String?
    
    let id: Int32?
    
    let investmentAmount: Int32?    //个人业绩（所有投资的本金之和），单位USDT，也就是美元
    
    let level: String?  //REGULAR: 普通节点, GOLDEN: 黄金节点, DIAMOND: 钻石节点, SUPER: 超级节点, NONE: 空节点
    
    let mobile: String?
    
    let realNameStatus: Int32?  //认证状态：0：没有实名验证通过，1： 已经实名验证通过，2：已经提交实名验证，待验证，3：实名验证失败，退回用户重新提交
    
    let registerTime: String?   //注册时间
    
    let teamInvestmentAmount: Double?   //团队业绩（不包含本人）
    
    let totalNumberInvitations: Int32?  //邀请总人数（团队总人数）
    
    let totalValidNumberInvitations: Int32? //有效邀请总人数(指有过投资的人数)
    
    let tradeFeeConversion: Double? //该下级用户给当前上级的币币和OTC交易手续费返还金额。单位USDT
    
    let tradeFees:tradeFeeModel?    //该下级用户给当前上级的币币和OTC交易手续费返还金额
    
    let userName: String?
    
    struct tradeFeeModel: Codable {
        let amount: Double?
        
        let coinName: String?
    }
    
}
