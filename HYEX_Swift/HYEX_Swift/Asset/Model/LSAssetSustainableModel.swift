//
//  LSAssetSustainableModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import Foundation
struct LSAssetSustainableModel: Codable {
    
    let sumPnl: Double?
    
    let sumPnlConvert: Double?
    
    let userPcVOList:[LSSustainableListModel]?
    
    let datasource:[LSSustainableListModel]?//网络最初的展示数据
    
    struct LSSustainableListModel: Codable {
        
        let balance: Double?
        
        let coinName: String?
        
        let createdAt: String?
        
        let id: Int32?
        
        let marginBalance: Double?
        
        let marginFrozen: Double?
        
        let marginOccupy: Double?
        
        let marginPer: Double?
        
        let pnlConvert: Double?
        
        let quoteCurrency: String?
        
        let realizedPnl: Double?
        
        let settlementCurrency: String?
        
        let totalPnl: Double?
        
        let unrealizedPnl: Double?
        
        let userId: Int32?
        
        let pcMarketName: String?
    }
}
