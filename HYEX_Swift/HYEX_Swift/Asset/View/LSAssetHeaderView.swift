//
//  LSAssetHeaderView.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import UIKit

let KHiddenAssetKey = "hiddenAsset"


class LSAssetHeaderView: UIView {

    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var totalBalanceConvert: UILabel!
    @IBOutlet weak var hiddenBtn: UIButton!
    
    var manager: LSAssetManager?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewGradient(with: [HEXCOLOR(h: 0x3685F9, alpha: 1).cgColor,HEXCOLOR(h: 0x5E2CEF, alpha: 1).cgColor], gradient: .LeftToRight)
        if let status = UserDefaults.standard.value(forKey: KHiddenAssetKey) {
            if status as! Bool {
                let imageName = status as! Bool == true ? "show_eye_open" : "show_eye"
                
                hiddenBtn.setImage(UIImage(named: imageName), for: .normal)
            }else{
                hiddenBtn.setImage(UIImage(named: "show_eye"), for: .normal)
            }
        }
    }
    func reloadHeaderAsset(with totalBa: Double,totalConvert: Double) {
        totalBalance.text = String(format: "%.8f", totalBa)
        totalBalanceConvert.text = String(format: "%.8f", totalConvert)
    }
    @IBAction func showAssetSecrutyEntryAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.totalBalance.text = "****"
            self.totalBalanceConvert.text = "****"
        }
        UserDefaults.standard.setValue(sender.isSelected, forKey: KHiddenAssetKey)
        if let _delegate = manager!.delegate {
            _delegate.assetHiddenAction()
        }
    }
    
    // MARK: 划转
    @IBAction func transferAction(_ sender: UIButton) {
        if let _delegate = manager!.delegate {
            _delegate.assetTransferAction()
        }
    }
    
    // MARK: 提币
    @IBAction func withdrawAction(_ sender: UIButton) {
        if let _delegate = manager!.delegate {
            _delegate.assetWithdrawAction()
        }
    }
    
    // MARK: 充币
    @IBAction func rechargeAction(_ sender: UIButton) {
        if let _delegate = manager!.delegate {
            _delegate.assetRechargeAction()
        }
    }
}

