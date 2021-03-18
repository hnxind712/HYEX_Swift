//
//  LSAssetManager.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import Foundation
import SwiftyJSON

fileprivate let KAssetUrl = "/finance/user-all-balance"

class LSAssetManager {
    var assetIndex: Int32 = 0//0为币币账户，1为永续账户
    
    var isHiddenSmall: Bool = false //是否隐藏小币种
    
    var searchKey: String?
    
    weak var delegate: LSAssetDelegate?//协议
    
    var assetModel: LSAssetListModel?
    
    // MARK: 获取资产
    func getAsset(completed: @escaping((_ datasource: [Any])->())) {
        if let model = assetModel {//如果存在则直接处理数据
            if self.assetIndex == 1 {
                //还需要处理网关
                completed((model.pcBalanceVo?.userPcVOList)!)
            }else{
                completed((model.coinBalanceVo?.userCoinVoList)!)
            }
        }else{
            //请求数据
            LSNetRequest.sharedInstance.getRequest(KAssetUrl) { (response) in
                let json = JSON(response)
                if json["statusCode"].int == 0 {
                    let data = response as? Dictionary<String,Any>
                    self.assetModel = decodeJsonToModel(json: data!["content"], ele: LSAssetListModel.self)
                    if self.assetIndex == 1 {
                        //还需要处理网关
                        completed((self.assetModel?.pcBalanceVo?.userPcVOList)!)
                    }else{
                        completed((self.assetModel?.coinBalanceVo?.userCoinVoList)!)
                    }
                }
            }
        }
    }
}
protocol LSAssetDelegate: NSObjectProtocol {
    
    // MARK: headerView代理
    func assetRechargeAction()//充币
    func assetWithdrawAction()//提币
    func assetTransferAction()//划转
    func assetHiddenAction()//隐藏资产
    
    // MARK: sectionView代理
    func switchCurrencyAccountAction(with index: Int32)//切换账户
    func hiddenSmallAction(with hidden: Bool)//隐藏小币种
    func addGatewayAction()//添加网关
    func textfieldDidChange(with key: String)//搜索币种
}
