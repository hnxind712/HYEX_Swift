//
//  LSPayMethodBindVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/15.
//

import UIKit
import SwiftyJSON

enum KPayMethod {
    case bankCard,wechat,alipay
}
//获取支付方式信息
fileprivate let KPayMethodInfoUrl = "/bank/bank-addresses"

//关闭或开启
fileprivate let KPaymethodOnUrl = "/bank/enable-disable"

class LSPayMethodBindVC: LSBaseViewController {
    //银行卡
    @IBOutlet weak var noBankCardView: UIView!
    @IBOutlet weak var bankCardView: UIView!
    @IBOutlet weak var bankCardOpenLabel: UILabel!
    @IBOutlet weak var bankCardSwitch: UISwitch!
    @IBOutlet weak var bankCardInfo: UILabel!
    @IBOutlet weak var bankName: UILabel!
    
    //微信
    @IBOutlet weak var noWechatView: UIView!
    @IBOutlet weak var noWechatHeight: NSLayoutConstraint!
    @IBOutlet weak var noWechatTop: NSLayoutConstraint!
    @IBOutlet weak var wechatView: UIView!
    @IBOutlet weak var wechatHeight: NSLayoutConstraint!
    @IBOutlet weak var weOpenLabel: UILabel!//微信是否开启
    @IBOutlet weak var wechatSwitch: UISwitch!
    @IBOutlet weak var weChatInfo: UILabel!
    
    //支付宝
    @IBOutlet weak var noAlipayView: UIView!
    @IBOutlet weak var alipayView: UIView!
    @IBOutlet weak var alipayOpenLabel: UILabel!//支付宝是否开启
    @IBOutlet weak var alipaySwitch: UISwitch!
    @IBOutlet weak var alipayInfo: UILabel!
    
    var bankModel: LSPayMethodInfo?
    
    var wechatModel: LSPayMethodInfo?
    
    var alipayModel: LSPayMethodInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "收付款设置".localized
        
        setupBind()
    }
    func setupBind() {
        //请求三个方式的数据
        DispatchQueue.global().async {
            self.getPayMethodInfo(with: .bankCard)
            self.getPayMethodInfo(with: .wechat)
            self.getPayMethodInfo(with: .alipay)
        }
    }
    // MARK: 获取对应配置的详细信息
    func getPayMethodInfo(with method:KPayMethod){
        
        let params: [String : Int] = ["bankType":payMethodType(with: method)]
        LSNetRequest.sharedInstance.getRequest(KPayMethodInfoUrl, params: params) { (response) in
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                print("打印顺序 = %@",params)
                DispatchQueue.main.async{
                    let list = json["content"].array
                    print(list)
                    if list!.count > 0 {
                        if let data = response as? Dictionary<String,Any> {
                            let infos:[LSPayMethodInfo] = decodeJsonToModel(json: data["content"],ele: [LSPayMethodInfo].self)!
                            self.configureView(with:method,model:infos.first)
                        }
                    }else{
                        self.configureView(with:method)
                    }
                }
            }else{
                
            }
        } failure: { (error) in
            self.view.makeToast("网络请求失败".localized)
        }
    }
    // MARK: 获取请求参数
    func payMethodType(with method:KPayMethod) -> Int {
        let dic: [KPayMethod : Int] = [
            .bankCard : 0,
            .alipay : 1,
            .wechat : 2
        ]
        return dic[method]!
    }
    // MARK: 配置界面信息
    func configureView(with method: KPayMethod, model: LSPayMethodInfo? = nil) {
        print("来了");
        if method == .bankCard {//银行卡
            bankModel = model
            if model != nil {//说明存在银行卡
                self.noBankCardView.isHidden = true
                self.bankCardView.isHidden = false
            }else{
                self.noBankCardView.isHidden = false
                self.bankCardView.isHidden = true
            }
            if model?.status == 1 {
                bankCardOpenLabel.text = "已启用".localized
                bankCardOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                bankCardSwitch.isOn = true
            }else{
                bankCardOpenLabel.text = "已禁用".localized
                bankCardOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                bankCardSwitch.isOn = false
            }
            bankName.text = model?.bankName
            bankCardInfo.text = "\(model!.bankUser)" + " " + "\(model!.bankNo)"
        }else if method == .wechat{//微信
            wechatModel = model
            if model != nil {//说明存在微信支付
                self.wechatView.isHidden = false
                self.noWechatView.isHidden = true
                self.noWechatTop.constant = 10
                self.noWechatHeight.constant = 40
            }else{
                self.wechatHeight.constant = 136
                self.wechatView.isHidden = true
                self.noWechatView.isHidden = false
            }
            if model?.status == 1 {
                weOpenLabel.text = "已启用".localized
                weOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                wechatSwitch.isOn = true
            }else{
                weOpenLabel.text = "已禁用".localized
                weOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                wechatSwitch.isOn = false
            }
            weChatInfo.text = "\(model!.bankUser)" + " " + "\(model!.bankNo)"
        }else{
            alipayModel = model
            if model != nil {
                self.alipayView.isHidden = false
                self.noAlipayView.isHidden = true
            }else{
                self.alipayView.isHidden = true
                self.noAlipayView.isHidden = false
            }
            if model?.status == 1 {
                alipayOpenLabel.text = "已启用".localized
                alipayOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                alipaySwitch.isOn = true
            }else{
                alipayOpenLabel.text = "已禁用".localized
                alipayOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                alipaySwitch.isOn = false
            }
            alipayInfo.text = "\(model!.bankUser)" + " " + "\(model!.bankNo)"
        }
    }
    @IBAction func bankSwitchAction(_ sender: UISwitch) {
        switchOnOrOff(with: .bankCard, isOn: sender.isOn)
    }
    @IBAction func wechatSwitchAction(_ sender: UISwitch) {
        switchOnOrOff(with: .wechat, isOn: sender.isOn)
    }
    @IBAction func alipaySwitchAction(_ sender: UISwitch) {
        switchOnOrOff(with: .alipay, isOn: sender.isOn)
    }
    private func switchOnOrOff(with method: KPayMethod, isOn: Bool){
        let params: [String : Any] = ["bankType":payMethodType(with: method),"status":isOn]
        LSNetRequest.sharedInstance.postRequest(KPaymethodOnUrl, params: params) { (reponse) in
            let json = JSON(reponse)
            if json["statusCode"].int == 0 {
                if method == .bankCard {
                    if isOn {
                        self.bankCardOpenLabel.text = "已启用".localized
                        self.bankCardOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                    }else{
                        self.bankCardOpenLabel.text = "已禁用".localized
                        self.bankCardOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                    }
                    self.bankCardSwitch.isOn = isOn
                }else if method == .wechat{
                    if isOn {
                        self.weOpenLabel.text = "已启用".localized
                        self.weOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                    }else{
                        self.weOpenLabel.text = "已禁用".localized
                        self.weOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                    }
                    self.wechatSwitch.isOn = isOn
                }else{
                    if isOn {
                        self.alipayOpenLabel.text = "已启用".localized
                        self.alipayOpenLabel.textColor = HEXCOLOR(h: 0x00A985, alpha: 1)
                    }else{
                        self.alipayOpenLabel.text = "已禁用".localized
                        self.alipayOpenLabel.textColor = HEXCOLOR(h: 0xA2A2A2, alpha: 1)
                    }
                    self.alipaySwitch.isOn = isOn
                }
            }else{
                self.view.makeToast(json["errorMessage"].string)
            }
        } failure: { (error) in
            self.view.makeToast(error.localizedDescription)
        }

    }
    //绑定银行卡
    @IBAction func bindBankCardAction(_ sender: UIButton) {
        let addBank = LSAddBankInfoViewController()
        addBank.defultModel = bankModel
        self.navigationController?.pushViewController(addBank, animated: true)
    }
    @IBAction func modifyBankCardAction(_ sender: UIButton) {
        let addBank = LSAddBankInfoViewController()
        addBank.defultModel = bankModel
        self.navigationController?.pushViewController(addBank, animated: true)
    }
    //绑定微信
    @IBAction func bindWechatAction(_ sender: UIButton) {
        let addWe = LSAddWechatAndAlipayVC()
        addWe.type = .wechat
        addWe.defultModel = wechatModel
        self.navigationController?.pushViewController(addWe, animated: true)
    }
    @IBAction func modifyWechatAction(_ sender: UIButton) {
        let addWe = LSAddWechatAndAlipayVC()
        addWe.type = .wechat
        addWe.defultModel = wechatModel
        self.navigationController?.pushViewController(addWe, animated: true)
    }
    //绑定支付宝
    @IBAction func bindAlipayAction(_ sender: UIButton) {
        let addWe = LSAddWechatAndAlipayVC()
        addWe.type = .alipay
        addWe.defultModel = alipayModel
        self.navigationController?.pushViewController(addWe, animated: true)
    }
    @IBAction func modifyAlipayAction(_ sender: UIButton) {
        let addWe = LSAddWechatAndAlipayVC()
        addWe.type = .alipay
        addWe.defultModel = alipayModel
        self.navigationController?.pushViewController(addWe, animated: true)
    }
}
