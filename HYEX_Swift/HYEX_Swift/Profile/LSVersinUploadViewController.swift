//
//  LSVersinUploadViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit

class LSVersinUploadViewController: LSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "检查更新".localized
    }
    
    // MARK: 更新
    @IBAction func updateAction(_ sender: UIButton) {
        AppDelegate.shared.updateVersion()
    }
    
    // MARK: 查看隐私协议
    @IBAction func checkPrivacyAgreementAction(_ sender: UIButton) {
        let helpCenter = LSHelpCenterViewController()
        helpCenter.type = .privacy
        self.navigationController?.pushViewController(helpCenter, animated: true)
    }
    
}
