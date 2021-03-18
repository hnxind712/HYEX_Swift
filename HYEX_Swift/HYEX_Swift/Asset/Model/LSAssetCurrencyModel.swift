//
//  LSAssetCurrencyModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import Foundation
struct LSAssetCurrencyModel: Codable {
    
    let sumAllConvert: Double?
    
    let sumCoinConvert: Double?
    
    let userCoinVoList:[LSCurrencyListModel]?
    
    let datasource:[LSCurrencyListModel]?//网络最初的展示数据
    
    struct LSCurrencyListModel: Codable {
        
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
