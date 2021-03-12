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
    }
    func setupLayout() {
        headerView.viewGradient(with: [HEXCOLOR(h: 0x3685F9, alpha: 1).cgColor,HEXCOLOR(h: 0x5E2CEF, alpha: 1).cgColor], gradient: .LeftToRight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //下拉刷新
        tableView.spr_setTextHeader {
            self.index = 1
            self.setupBind()
        }
        tableView.spr_setTextFooter {
            self.index += 1
            self.setupBind()
        }
    }
    func setupBind() {
        
    }
}
extension LSInviteListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSInviteListCell.self)) as! LSInviteListCell
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
