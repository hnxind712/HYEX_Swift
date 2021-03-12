//
//  LSAuthenticationStatusVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit

enum KAuthentiCationStatus{
    case process,passed
}

class LSAuthenticationStatusVC: LSBaseViewController {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDescLabel: UILabel!

    var authentiCationStatus: KAuthentiCationStatus = .process
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "身份认证".localized
        if authentiCationStatus == .process {
            statusImage.image = UIImage(named: "card_submit_success")
            statusLabel.text = "资料提交成功".localized
            statusDescLabel.text = "等待审核中，我们将尽快为您处理。".localized
        }else{
            statusImage.image = UIImage(named: "card_verify_sucess")
            statusDescLabel.text = "已通过认证！".localized
            if let realName = LSUserInfo.sharedInstance()?.realName{
                if ((realName.range(of: "*")) != nil) {
                    statusLabel.text = realName
                }else{
                    if realName.count > 3 {
                        statusLabel.text = (realName as NSString).replacingCharacters(in: NSMakeRange(1, 2), with: "**")
                    }else{
                        statusLabel.text = (realName as NSString).replacingCharacters(in: NSMakeRange(1, 1), with: "*")
                    }
                }
            }
        }
    }
}
