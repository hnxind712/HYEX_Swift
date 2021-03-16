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
let KPayMethodInfoUrl = "/bank/bank-addresses"

class LSPayMethodBindVC: LSBaseViewController {
    //银行卡
    @IBOutlet weak var noBankCardView: UIView!
    @IBOutlet weak var bankCardView: UIView!
    @IBOutlet weak var bankCardOpenLabel: UILabel!
    @IBOutlet weak var bankCardSwitch: UISwitch!
    
    
    
    @IBOutlet weak var noWechatView: UIView!
    @IBOutlet weak var noWechatTop: NSLayoutConstraint!
    @IBOutlet weak var wechatView: UIView!
    @IBOutlet weak var wechatTop: NSLayoutConstraint!
    @IBOutlet weak var weOpenLabel: UILabel!//微信是否开启
    @IBOutlet weak var wechatSwitch: UISwitch!
    
    @IBOutlet weak var noAlipayView: UIView!
    @IBOutlet weak var noAliTop: NSLayoutConstraint!
    @IBOutlet weak var alipayView: UIView!
    @IBOutlet weak var alipayTop: NSLayoutConstraint!
    @IBOutlet weak var alipayOpenLabel: UILabel!//支付宝是否开启
    @IBOutlet weak var alipaySwitch: UISwitch!
    
    let sema = DispatchSemaphore.init(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "收付款设置".localized
        
        setupBind()
    }
    func setupBind() {
        //请求三个方式的数据
//
//        let oprationBank = BlockOperation.init {
//            self.getPayMethodInfo(with: .bankCard)
//        }
//        let oprationWechat = BlockOperation.init {
//            self.getPayMethodInfo(with: .wechat)
//        }
//        let oprationAlipay = BlockOperation.init {
//            self.getPayMethodInfo(with: .alipay)
//        }
//        oprationAlipay.addDependency(oprationWechat)
//        oprationWechat.addDependency(oprationBank)
//
//        let oprationQueue = OperationQueue.init()
//        oprationQueue.addOperations([oprationBank,oprationWechat,oprationAlipay], waitUntilFinished: true)
        
        let queue = DispatchQueue.init(label: "load",attributes: DispatchQueue.Attributes.concurrent)
        queue.async {
//            self.sema.wait()
            self.getPayMethodInfo(with: .bankCard)
        }
        queue.async {
//            self.sema.wait()
            self.getPayMethodInfo(with: .wechat)
        }
        queue.async {
//            self.sema.wait()
            self.getPayMethodInfo(with: .alipay)
        }
        
    }
    // MARK: 获取对应配置的详细信息
    func getPayMethodInfo(with method:KPayMethod){
        
        let params: [String : Int] = ["bankType":payMethodType(with: method)]
        LSNetRequest.sharedInstance.getRequest(KPayMethodInfoUrl, params: params) { (response) in
            self.sema.signal()
            let json = JSON(response)
            if json["statusCode"].int == 0 {
                print("打印顺序 = %@",params)
                let list = json["content"].array
                if list!.count > 0 {
                    if let data = response as? Dictionary<String,Any> {
                        DispatchQueue.main.async{
                            let model = decodeJsonToModel(json: data["content"],ele: LSPayMethodInfo.self)
                            self.configureView(with:method,model:model)
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        self.configureView(with:method)
                    }
                }
            }else{
                
            }
        } failure: { (error) in
            self.sema.signal()
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
        if method == .bankCard {//银行卡
            if model != nil {//说明存在银行卡
                self.noBankCardView.isHidden = true
                self.bankCardView.isHidden = false
            }else{
                self.noBankCardView.isHidden = false
                self.bankCardView.isHidden = true
            }
        }else if method == .wechat{//微信
            if self.noBankCardView.isHidden == true {//如果没有银行卡
                self.noWechatTop.constant = 140
                self.wechatTop.constant = 140
            }else{
                self.noWechatTop.constant = 60
                self.wechatTop.constant = 60
            }
            if model != nil {//说明存在微信支付
                self.wechatView.isHidden = false
                self.noWechatView.isHidden = true
            }else{
                self.wechatView.isHidden = true
                self.noWechatView.isHidden = false
            }
        }
        else{
            if self.noWechatView.isHidden == true {
                self.noAliTop.constant = 276
                self.alipayTop.constant = 276
            }else{
                self.noWechatTop.constant = 110
                self.alipayTop.constant = 110
            }
            if model != nil {
                self.alipayView.isHidden = false
                self.noAlipayView.isHidden = true
            }else{
                self.alipayView.isHidden = true
                self.noAlipayView.isHidden = false
            }
        }
    }
}
