//
//  LSAssetListModel.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import Foundation
struct LSAssetListModel: Codable {
    
    let sumBalance: Double?
    
    let sumBalanceConvert: Double?
    
    let pcBalanceVo:LSAssetSustainableModel?
    
    let coinBalanceVo: LSAssetCurrencyModel?
}
