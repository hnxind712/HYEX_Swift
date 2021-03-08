//
//  LSMarketListViewController.swift
//  HYEX_Swift
//
//  Created by heyong on 2021/3/8.
//

import UIKit

//获取市场列表数据
fileprivate let KMarketListURL = "/marketOpt/getMarkList"


class LSMarketListViewController: LSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    //列表数据
    var datasource:[LSMarketListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "行情".localized
        
        setuoLayout()
        
        setupBind()
        
        initTimer()
        // Do any additional setup after loading the view.
    }
    func setuoLayout() {
        tableView.register(UINib.init(nibName: String(describing: LSMarketListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSMarketListCell.self))
        tableView.tableFooterView = UIView()
    }
    //MARK: 初始化定时器
    func initTimer() {
        //初始化定时器
        timer.schedule(deadline: .now(), repeating: 10, leeway: .milliseconds(10))
        timer.setEventHandler {
            
        }
    }
    func setupBind() {
        LSNetRequest.sharedInstance.getRequest(KMarketListURL, params: nil) { (response) in
            print(response)
            if let data = response as? Dictionary<String,Any>{
                if data["statusCode"] as! Int == 0 {//成功
                    let array:[LSMarketListItemModel] = decodeJsonToModel(json: data["content"], ele: [LSMarketListItemModel].self)!
                    let market:LSMarketListItemModel = array.last!
                    
                    self.datasource = market.marketList!
                    self.tableView.reloadData()
                }
            }
        } failure: { (error) in
            
        }
    }
    //MARK: 币种排位
    @IBAction func currencySortAction(_ sender: UIButton) {
    }
    
    //MARK: 价格排位
    @IBAction func priceSortAction(_ sender: UIButton) {
    }
    //MARK: 涨幅
    @IBAction func fullDownAction(_ sender: UIButton) {
    }
}
extension LSMarketListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = datasource?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LSMarketListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSMarketListCell.self)) as! LSMarketListCell
        cell.marketModel = datasource?[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //跳转到k线
    }
}
