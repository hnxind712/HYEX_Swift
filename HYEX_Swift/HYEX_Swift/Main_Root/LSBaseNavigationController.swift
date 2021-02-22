//
//  LSBaseNavigationController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/1/27.
//

import UIKit

class LSBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
 
}
extension LSBaseNavigationController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count > 1 {
            let leftBtn: UIButton = UIButton.init(type: .custom)
            leftBtn.setImage(UIImage.init(named: "icon_back"), for: .normal)
            leftBtn.setImage(UIImage.init(named: "icon_back"), for: .highlighted)
            leftBtn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
            leftBtn.frame = CGRect.init(x: 0, y: 0, width: 45, height: 35)
            leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
            let leftItem: UIBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
            let spaceItem: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            
            viewController.navigationItem.leftBarButtonItems = [leftItem,spaceItem]
        }
    }
}
