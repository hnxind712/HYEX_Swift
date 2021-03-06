//
//  LSMarketListModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import Foundation
struct LSMarketListModel: Codable{
    /*
     "changeRate": 0,
     "coinName": "string",
     "coinUrl": "string",
     "dealTimes": 0,
     "endTime": 0,
     "firstPrice": 0,
     "lastPrice": 0,
     "latestCnyPrice": 0,
     "latestPrice": 0,
     "mainArea": 0,
     "maxPrice": 0,
     "minPrice": 0,
     "mineArea": 0,
     "preArea": 0,
     "priceBeforeStat": 0,
     "settlementCurrency": "string",
     "startTime": 0,
     "sumAmount": 0,
     "sumCurrency": 0,
     "ukzArea": 0
     */
    let changeRate: Double?
    
    let coinName: String?
    
    let coinUrl: String?
    
    let dealTimes: Int32?
    
    let endTime: Int32?
    
    let firstPrice: Double?
    
    let lastPrice: Double?
    
    let latestCnyPrice: Double?
    
    let latestPrice: Double?
    
    let mainArea: Int32?
    
    let marketId: Int32?
    
    let maxPrice: Double?
    
    let minPrice: Double?
    
    let mineArea: Int32?
    
    let preArea: Int32?
    
    let priceBeforeStat: Double?
    
    let settlementCurrency: String?
    
    let startTime: Int32?
    
    let sumAmount: Double?
    
    let sumCurrency: Double?
    
    let ukzArea: Int32?
}
