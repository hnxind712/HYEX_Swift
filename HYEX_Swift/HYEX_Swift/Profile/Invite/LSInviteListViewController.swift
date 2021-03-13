//
//  LSInviteListViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit
import SwiftyJSON
import SwiftPullToRefresh

let KGetMyTeamUrl = "/user/getMyTeam"

let KGetReferrerUrl = "/user/referrer"

class LSInviteListViewController: LSBaseViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var totalInvite: UILabel!
    @IBOutlet weak var earningConvert: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var index: Int = 1
    lazy var datasource:[LSInviteListModel] = {
        let array = [LSInviteListModel]()
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的推广".localized
        
        setupLayout()
        
        tableView.spr_beginRefreshing()
    }
    func setupLayout() {
        headerView.viewGradient(with: [HEXCOLOR(h: 0x3685F9, alpha: 1).cgColor,HEXCOLOR(h: 0x5E2CEF, alpha: 1).cgColor], gradient: .LeftToRight)
        tableView.register(UINib.init(nibName: String(describing: LSInviteListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSInviteListCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //下拉刷新
        tableView.spr_setTextHeader {
            self.index = 1
            self.setupBind()
            self.getTeamInfo()
        }
        tableView.spr_setTextFooter {
            self.index += 1
            self.setupBind()
        }
    }
    func setupBind() {
        LSNetRequest.sharedInstance.getRequest(KGetReferrerUrl, params: ["pageNo":index,"pageSize":KPageSize]) { (response) in
            self.tableView.spr_endRefreshing()
            if JSON(response)["statusCode"].int == 0 {
                if let data = response as? Dictionary<String, Any> {
                    if self.index == 1 {
                        self.datasource.removeAll()
                    }
                    self.datasource += decodeJsonToModel(json: data["content"], ele: [LSInviteListModel].self)!
                    self.tableView.reloadData()
                }
            }
        } failure: { (error) in
            self.tableView.spr_endRefreshing()
        }
    }
    func getTeamInfo() {
        LSNetRequest.sharedInstance.getRequest(KGetMyTeamUrl, params: nil) { (response) in
            let data = JSON(response)
            if data["statusCode"].int == 0 {
                self.totalInvite.text = "\(data["content"]["totalNumberInvitations"])"
                self.earningConvert.text = "\(data["content"]["investmentAmount"])"
            }else{
                self.view.makeToast(data["errorMessage"].string)
            }
        } failure: { (error) in
            
        }
    }
}
extension LSInviteListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSInviteListCell.self)) as! LSInviteListCell
        cell.selectionStyle = .none
        cell.model = datasource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
