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
        tableView.spr_setTextHeader { [weak self] in
            self!.tableView.spr_endRefreshing()
        }
        tableView.spr_setTextFooter {
            
        }
    }
    func setupBind() {
        let params = ["pageSize":KPageSize,"pageNo":index]
        LSNetRequest.sharedInstance.getRequest(KFeedbackRecordListURL, params: params) { (response) in
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
                }
            }else{
                self.view.makeToast(data["errorMessage"].string)
            }
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }

        
    }
}
extension LSFeedBackRecordVC{
    
}
