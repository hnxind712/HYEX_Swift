//
//  LSFeedBackRecordVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import UIKit
import SwiftPullToRefresh
import SwiftyJSON

let KFeedbackRecordListURL = "/user/feedBackList"


class LSFeedBackRecordVC: LSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var index:Int = 1//当前页
    
    lazy var datasource:[LSFeedBackModel] = {
        let array = Array<LSFeedBackModel>()
        return array
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        setupBind()
    }
    func setupLayout(){
        tableView.register(UINib.init(nibName: String(describing: LSFeedBackRecordCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSFeedBackRecordCell.self))
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        //刷新
        tableView.spr_setTextHeader { [weak self] in
            self?.index = 1
            self?.setupBind()
        }
        tableView.spr_setTextFooter { [weak self] in
            self?.index += 1
            self?.setupBind()
        }
    }
    func setupBind() {
        let params = ["pageSize":KPageSize,"pageNo":index]
        LSNetRequest.sharedInstance.getRequest(KFeedbackRecordListURL, params: params) { (response) in
            self.tableView.spr_endRefreshing()
            let data = JSON(response)//拿到数组
            if data["statusCode"].int == 0{
                if self.index == 1 {
                    self.datasource.removeAll()
                }
                self.tableView.spr_endRefreshing()
                if let dic = response as? Dictionary<String,Any> {
                    let list = decodeJsonToModel(json: dic["content"], ele: [LSFeedBackModel].self)
                    self.datasource += list!
                    print(self.datasource)
                    self.tableView.reloadData()
                }
            }else{
                self.view.makeToast(data["errorMessage"].string)
            }
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }
    }
}
extension LSFeedBackRecordVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LSFeedBackRecordCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSFeedBackRecordCell.self)) as! LSFeedBackRecordCell
        cell.selectionStyle = .none
        cell.model = datasource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = datasource[indexPath.row]
        if let responseMessage = model.responseMessage{
            if responseMessage.count > 0 {
                let height = model.responseMessage?.height(with: CGSize.init(width: kScreen_width - 84, height: CGFloat(MAXFLOAT)), [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),NSAttributedString.Key.foregroundColor: HEXCOLOR(h: 0x505254, alpha: 1)])
                return 80 + height! + 14
            }
            return 80
        }
        return 80
    }
}
