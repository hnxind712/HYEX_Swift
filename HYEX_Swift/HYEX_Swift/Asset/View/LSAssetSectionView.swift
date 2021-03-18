//
//  LSAssetSectionView.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import UIKit

class LSAssetSectionView: UIView {

    @IBOutlet weak var assetMessage: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var balanceConvert: UILabel!
    @IBOutlet weak var coinSearchInput: UITextField!
    
    var manager: LSAssetManager?
    var selectedBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBtn = self.viewWithTag(10) as? UIButton
        coinSearchInput.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: 刷新section数据
    func reloadAsset(with ba: Double,balanceCon: Double) {
        if let value = UserDefaults.standard.value(forKey: KHiddenAssetKey) {
            if value as! Bool {
                balance.text = "****"
                balanceConvert.text = "****"
            }else{
                balance.text = String(format: "%.8f", ba)
                balanceConvert.text = String(format: "%.8f", balanceCon)
            }
        }
    }
    
    // MARK: 代理事件
    @objc func textfieldDidChange(_ textfield:UITextField){
        if let _delegate = manager?.delegate {
            _delegate.textfieldDidChange(with: textfield.text!)
        }
    }
    @IBAction func coinCurrencyAccountAction(_ sender: UIButton) {
        guard sender != selectedBtn else {
            return
        }
        selectedBtn.isSelected = false
        sender.isSelected = true
        selectedBtn = sender
        manager?.assetIndex = 1
        if let _delegate = manager?.delegate {
            _delegate.switchCurrencyAccountAction(with: 0)
        }
    }
    @IBAction func sustainableAccountAction(_ sender: UIButton) {
        guard sender != selectedBtn else {
            return
        }
        selectedBtn.isSelected = false
        sender.isSelected = true
        selectedBtn = sender
        manager?.assetIndex = 1
        if let _delegate = manager?.delegate {
            _delegate.switchCurrencyAccountAction(with: 1)
        }
    }
    @IBAction func hiddenSmallAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let _delegate = manager?.delegate {
            _delegate.hiddenSmallAction(with: sender.isSelected)
        }
    }
    @IBAction func addGatewayAction(_ sender: UIButton) {
        if let _delegate = manager?.delegate {
            _delegate.addGatewayAction()
        }
    }
}
