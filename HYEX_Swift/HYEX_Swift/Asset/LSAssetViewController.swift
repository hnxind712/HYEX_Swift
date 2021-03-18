//
//  LSAssetViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import UIKit

class LSAssetViewController: LSBaseViewController {
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    
    let manager: LSAssetManager = LSAssetManager()
    
    var headerView: LSAssetHeaderView?{
        let header = Bundle.main.loadNibNamed(String(describing: LSAssetHeaderView.self), owner: nil, options: nil)
        if let view = header?.first as? LSAssetHeaderView {
            view.manager = self.manager
            self.view.insertSubview(view, at: 0)
            view.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview().offset(0)
            }
            return view
        }
        return nil
    };
    
    var sectionView: LSAssetSectionView?{
        let section = Bundle.main.loadNibNamed(String(describing: LSAssetSectionView.self), owner: nil, options: nil)
        if let view = section?.first as? LSAssetSectionView {
            view.manager = self.manager
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            return view
        }
        return nil
    }
    
    var datasource:[Any] = []
    
    // MARK: func
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        
        setupBind()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: 配置tableView
    private func setupLayout() {
        bgView.viewCornerRadius(CGSize(width: 10, height: 10), [.topLeft,.topRight])
        self.tableViewTop.constant = (headerView?.bounds.height)!
        tableView.register(UINib.init(nibName: String(describing: LSAssetCoinListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSAssetCoinListCell.self))
        tableView.register(UINib.init(nibName: String(describing: LSAssetSustainableListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LSAssetSustainableListCell.self))
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = sectionView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.spr_setTextHeader {//下拉刷新
            self.manager.assetModel = nil
            self.setupBind()
        }
        
    }
    
    private func setupBind() {
        manager.getAsset { (data) in
            self.datasource = data
            self.tableView.reloadData()
        }
    }
}
// MARK: manager代理
extension LSAssetViewController: LSAssetDelegate{

    
    func assetRechargeAction() {
        
    }
    
    func assetWithdrawAction() {
        
    }
    
    func assetTransferAction() {
        
    }
    
    func assetHiddenAction() {
        self.tableView.reloadData()
    }
    
    func switchCurrencyAccountAction(with index: Int32) {
        setupBind()
    }
    
    func hiddenSmallAction(with hidden: Bool) {
        manager.isHiddenSmall = hidden
        setupBind()
    }
    
    func addGatewayAction() {
        
    }
    
    func textfieldDidChange(with key: String) {
        manager.searchKey = key
        setupBind()
    }
    
    
}
// MARK: tableView代理
extension LSAssetViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if manager.assetIndex == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSAssetSustainableListCell.self)) as! LSAssetSustainableListCell
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LSAssetCoinListCell.self)) as! LSAssetCoinListCell
            
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return manager.assetIndex == 1 ? 145 : 105
    }
}
