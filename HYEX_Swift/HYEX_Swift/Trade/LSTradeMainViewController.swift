//
//  LSTradeMainViewController.swift
//  HYEX_Swift
//
//  Created by heyong on 2021/3/9.
//

import UIKit
import SnapKit

class LSTradeMainViewController: LSBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var selectedBtn: UIButton!
    lazy var sustainabilityVC: LSSustainabilityViewController = {
        let vc = LSSustainabilityViewController()
        
        return vc
    }()
    
    lazy var coinCurrencyVC: LSCoinCurrencyTradeVC = {
        let vc = LSCoinCurrencyTradeVC()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedBtn = view.viewWithTag(10086) as! UIButton //默认选中币币
        addChildVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func addChildVC() {
        
        self.addChildViewController(coinCurrencyVC)
        scrollView.addSubview(coinCurrencyVC.view)
        coinCurrencyVC.view.frame = CGRect(x: 0, y: 0, width: kScreen_width, height: scrollView.bounds.height)
//        coinCurrencyVC.view.snp.makeConstraints { (maker) in
//            maker.left.top.bottom.equalToSuperview()
//            maker.width.equalTo(kScreen_width)
//        }
        scrollView.contentSize = CGSize(width: 2 * kScreen_width, height: scrollView.bounds.height)
    }
    //币币
    @IBAction func coinCurrencyAction(_ sender: UIButton) {
        guard selectedBtn != sender else {
            return
        }
        sender.isSelected = true
        selectedBtn.isSelected = false
        selectedBtn = sender
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    //永续
    @IBAction func sustainabilityAction(_ sender: UIButton) {
        guard selectedBtn != sender else {
            return
        }
        sender.isSelected = true
        selectedBtn.isSelected = false
        selectedBtn = sender
        scrollView.setContentOffset(CGPoint(x: kScreen_width, y: 0), animated: true)
        if !sustainabilityVC.isViewLoaded {//如果没有加载
            self.addChildViewController(sustainabilityVC)
            scrollView.addSubview(sustainabilityVC.view)
            sustainabilityVC.view.frame = CGRect(x: kScreen_width, y: 0, width: kScreen_width, height: scrollView.bounds.height)
//            sustainabilityVC.view.snp.makeConstraints { (maker) in
//                maker.right.bottom.top.equalToSuperview()
//                maker.left.equalTo(kScreen_width)
//            }
        }
        
    }
    //法币
    @IBAction func otcAction(_ sender: UIButton) {
        let otc: LSOTCMainViewController = LSOTCMainViewController()
        navigationController?.pushViewController(otc, animated: true)
        
    }
}
extension LSTradeMainViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("进来了")
    }
}
