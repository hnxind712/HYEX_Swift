//
//  LSProfileViewController.swift
//  HYEX_Swift
//
//  Created by heyong on 2021/3/4.
//

import UIKit

//获取用户交易信息
fileprivate let KProfileGetTradeInfo = "/otc-trade/merchant/apply"

//区块链浏览地址
fileprivate let KBlockChainURL = "https://cn.etherscan.com/token/0xef00dc3491b333396e418cbe32435d97090b6be4"


//列表图片
fileprivate let KActivityImages = [["icon_mine_Account", "icon_otc_account"],["icon_mine_safety", "icon_verify_identity"],["icon_website", "icon_Blockchain","icon_language", "icon_submit_order", "icon_version"]]

//列表标题
fileprivate let KActivityTitles = [["商户中心".localized,"收款账户".localized],["安全中心".localized,"身份认证".localized],["官网".localized,"区块链浏览器".localized,"语言".localized,"提交工单".localized,"版本号".localized]]


class LSProfileViewController: LSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var tradeInfo: LSOTCTradeUserInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        setupBind()
    }
    
    func setupLayout() {
        tableView.register(UINib.init(nibName: String(describing: LSProfileCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSProfileCell.self))
        tableView.tableFooterView = UIView()
    }
    
    func  setupBind() {
        LSNetRequest.sharedInstance.getRequest(KProfileGetTradeInfo, params: nil) { (response) in
            if let data = response as? Dictionary<String, Any> as NSDictionary?{
                if data["statusCode"] as! Int == 0 {//说明拿到了数据
                    self.tradeInfo = decodeJsonToModel(json: data["content"], ele: LSOTCTradeUserInfo.self)
                }else{
                    self.view.makeToast(data["errorMessage"] as? String)
                }
            }
        } failure: { (error) in
            
        }

    }
}
extension LSProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return KActivityTitles.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = KActivityImages[section]
        
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LSProfileCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSProfileCell.self)) as! LSProfileCell
        cell.detailMessage.text = ""
        cell.icon.image = UIImage.init(named: KActivityImages[indexPath.section][indexPath.row])
        cell.title.text = KActivityTitles[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.title.text = "发布OTC广告".localized
                if tradeInfo?.status == 0 {
                    cell.title.text = "商户中心".localized
                }
            }else{
                cell.detailMessage.text = "法币收款账户".localized
                cell.detailMessage.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                cell.detailMessage.textAlignment = .right
            }
            break
        case 1: break
        case 2:
            switch indexPath.row {
            case 1:
                cell.detailMessage.text = KBlockChainURL
                cell.detailMessage.textColor = HEXCOLOR(h: 0x4162A6, alpha: 1)
                break
            case 2:
                cell.detailMessage.text = Localize.currentLanguage()
                cell.detailMessage.textColor = HEXCOLOR(h: 0x4162A6, alpha: 1)
                break
            case 3:
                cell.detailMessage.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                cell.detailMessage.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                
                break
            default:
                cell.detailMessage.text = ""
            }
            
            
            break
        default: break
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
