//
//  LSMainTabbarController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit

let KTabbarVC = "vc"
let KTabbarTitle = "title"
let KTabbarImage = "image"
let KTabbarSelectedImage = "selectedImage"
let KTabbarCount: Int = 5//定义为5个
//let KTabbarNormalColor = UIColo
enum KTabbarItemType: Int{
    case home = 0,market,trade,asset,profile
}
class LSMainTabbarController: UITabBarController {
    var type: KTabbarItemType = .home//默认选中为主页
    
    fileprivate let barDic: [KTabbarItemType:Any] =
        [KTabbarItemType.home:[KTabbarVC:"LSHomeViewController",
                               KTabbarTitle:"主页",
                               KTabbarImage:"icon_home",
                               KTabbarSelectedImage:"icon_home_h"
        ],
        KTabbarItemType.market:[KTabbarVC:"LSMarketListViewController",
                                KTabbarTitle:"行情",
                                KTabbarImage:"icon_market",
                                KTabbarSelectedImage:"icon_market_h"
        ],
        KTabbarItemType.trade:[KTabbarVC:"LSTradeMainViewController",
                               KTabbarTitle:"交易",
                               KTabbarImage:"icon_trade",
                               KTabbarSelectedImage:"icon_trade_h"
        ],
        KTabbarItemType.asset:[KTabbarVC:"LSHomeViewController",
                               KTabbarTitle:"资产",
                               KTabbarImage:"icon_purse",
                               KTabbarSelectedImage:"icon_purse_h"
        ],
        KTabbarItemType.profile:[KTabbarVC:"LSProfileViewController",
                                 KTabbarTitle:"我的",
                                 KTabbarImage:"icon_mine",
                                 KTabbarSelectedImage:"icon_mine_h"
        ]
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildControllers()
        // Do any additional setup after loading the view.
    }
    //添加子控制器
    private func setupChildControllers(){
        var childControllers:[LSBaseNavigationController] = []
        for k in 0..<KTabbarCount {
            if let dic = barDic[KTabbarItemType(rawValue: k)!] as? [String:String]{
                let appName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                if let childVcClass: AnyClass = NSClassFromString(appName + "." + dic[KTabbarVC]!){
                    let childType:UIViewController.Type = childVcClass as! UIViewController.Type
                    //创建控制器实例对象
                    let childVC = childType.init()
                    let nav: LSBaseNavigationController = LSBaseNavigationController.init(rootViewController: childVC)
                    nav.tabBarItem.title = (dic[KTabbarTitle])
                    nav.tabBarItem.image = UIImage(named: dic[KTabbarImage]!)
                    nav.tabBarItem.selectedImage = UIImage(named: dic[KTabbarSelectedImage]!)
                    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : HEXCOLOR(h: 0xc8c8c8, alpha: 1)], for: .normal)
                    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : HEXCOLOR(h: 0x5B5B5B, alpha: 1)], for: .selected)
                    childControllers.append(nav)
                }
            }
        }

        self.viewControllers = childControllers
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("点击了\(item)")
    }
}

