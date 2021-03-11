//
//  LSHomeViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit
import JXBanner
import Kingfisher

//banner地址
fileprivate let KBannerUrl = "/advertise"

//涨跌幅地址
fileprivate let KMarketUrl = "/market/stats-list"

//消息列表数据
fileprivate let KNoticeUrl = "/article"

//涨跌幅行高
fileprivate let KTabelRowHeight: CGFloat = 71

class LSHomeViewController: LSBaseViewController {

    // MARK: banner相关
    @IBOutlet weak var banner: JXBanner!//轮播
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var tableView: UITableView!//涨幅榜
    @IBOutlet weak var latestNotice: UILabel!//最新消息
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    // MARK: banner数据
    private var bannerDatasource:[LSBannerModel]?
    
    // MARK: collection数据
    private lazy var collectionTitles: [String] = {
        let array = ["转账".localized,"收款".localized,"账本".localized,"DEFI".localized,"币币".localized,"永续".localized,"法币".localized,"客服".localized]
        return array
    }()
    
    private lazy var collectionImages: [String] = {
        let images = ["icon_home_transfer", "icon_home_gathering", "icon_home_accountBook", "icon_home_difi", "icon_home_coin", "icon_home_sustainability", "icon_home_otc", "icon_home_service"]
        
        return images
    }()
    
    // MARK: 涨跌幅数据
    private var datasource: [LSMarketListModel]?
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
        getBannerDatasource()//获取banner数据
        
        getMarketDatasource()//获取涨跌幅数据
    }
    // MARK: 配置基本信息
    private func setupLayout(){
        //配置banner信息
        banner.delegate = self
        banner.dataSource = self
        
        //配置collection信息
        layout.itemSize = CGSize.init(width: 80, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: String(describing: LSHomeItemCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: LSHomeItemCell.self))
        
        //配置涨跌幅信息
        tableView.register(UINib.init(nibName: String(describing: LSMarketListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSMarketListCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    // MARK: 获取公告信息
    private func getNoticeListDatasource(){
        let params: [String : Any] = ["locale" : "zh_CN",
                                      "pageNo" : "1",
                                      "pageSize" : KPageSize,
                                      "type" : "CONTENT"]
        
        LSNetRequest.sharedInstance.getRequest(KNoticeUrl, params: params) { (response) in
            if let data = response as? Dictionary<String, Any>{
                var list = decodeJsonToModel(json: data["content"], ele: [LSNoticeListModel].self)!
                
                let latest: LSNoticeListModel = list.first!
                self.latestNotice.text = latest.title!
                
                let predicate = NSPredicate.init(format: "%@", "readFlag = 0")
             
//                let filtleList = list.filteredArrayUsingPredicate(predicate)
                   
                
            }
        } failure: { (error) in
            
        }

    }
    
    // MARK: 获取涨跌幅数据
    private func getMarketDatasource(){
        let params: [String : Any] = ["newCoin":false,"up":false,"rankingType":"CHANGE"]
        
        LSNetRequest.sharedInstance.getRequest(KMarketUrl, params: params) { (reponse) in
            print(reponse)
            if let data = reponse as? Dictionary<String, Any>{
                self.datasource = decodeJsonToModel(json: data["content"], ele: [LSMarketListModel].self)!
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
                if self.datasource!.count >= 3{
                    self.tableHeight.constant = 3 * KTabelRowHeight
                }else{
                    self.tableHeight.constant = self.tableView.contentSize.height
                }
            }
        } failure: { (error) in
            
        }

    }
    
    // MARK: 获取banner数据
    private func getBannerDatasource() {
        LSNetRequest.sharedInstance.getRequest(KBannerUrl, params: ["clientType":"2","locale":"zh_CN"]) { (response) in
            if let data = response as? Dictionary<String,Any>{
                self.bannerDatasource = decodeJsonToModel(json: data["content"], ele: [LSBannerModel].self)
                self.banner.reloadView()
            }
        } failure: { (error) in
            
        }
    }
    
    // MARK: 查看消息列表
    @IBAction func viewNoticeListAction(_ sender: UIButton) {
    }
    // MARK: 邀请好友
    @IBAction func inviteFriendAction(_ sender: UITapGestureRecognizer) {
    }

}

// MARK: banner代理
extension LSHomeViewController: JXBannerDelegate,JXBannerDataSource{
    //配置轮播时间为3秒
    func jxBanner(_ banner: JXBannerType,
                  params: JXBannerParams)
    -> JXBannerParams{
        return params.timeInterval(3)
    }
    
    func jxBanner(_ banner: JXBannerType, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        
        let bannerCell: JXBannerCell = cell as! JXBannerCell
        let model: LSBannerModel = bannerDatasource![index]
        
        bannerCell.imageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string:model.url!)!), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        return bannerCell
    }
    
    func jxBanner(numberOfItems banner: JXBannerType) -> Int {
        if let count = bannerDatasource?.count {//避免网络请求之前刷新数据
            return count
        }
        return 0
    }
    
    func jxBanner(_ banner: JXBannerType) -> (JXBannerCellRegister) {
        return JXBannerCellRegister(type: JXBannerCell.self, reuseIdentifier: "JXBannerCell")
    }
    //轮播点击事件
    func jxBanner(_ banner: JXBannerType,
                      didSelectItemAt index: Int) {
        print(" -- jxBanner select item -- \(index)  -- ")
    }
}

// MARK: collectionView代理
extension LSHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LSHomeItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LSHomeItemCell.self), for: indexPath) as! LSHomeItemCell
        
        cell.itemImage.image = UIImage.init(named: collectionImages[indexPath.row])
        
        cell.itemTitle.text = collectionTitles[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension LSHomeViewController: UITableViewDelegate,UITableViewDataSource{
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
        return KTabelRowHeight;
    }
}
