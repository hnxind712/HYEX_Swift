//
//  LSInviteViewController.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/10.
//

import UIKit
import SwiftyJSON

class LSInviteViewController: LSBaseViewController {

    @IBOutlet weak var inviteUrl: UILabel!
    @IBOutlet weak var inviteCode: UILabel!
    @IBOutlet weak var imageCode: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "邀请好友".localized
        
        checkVersion()
        // Do any additional setup after loading the view.
    }
    //获取邀请下载域名
    func checkVersion(){
        LSNetRequest.sharedInstance.getRequest(KGetAppVersionURL, params: ["platform":"ios"]) { (reponse) in
            let json = JSON(reponse)
            let download = json["content"]["referrerUrl"]
            if let userInfo = LSUserInfo.sharedInstance(){
                self.inviteUrl.text = "\(download)?invite=\(userInfo.inviteCode!)"
                self.inviteCode.text = userInfo.inviteCode!
                self.imageCode.image = self.loadQRcode(with: self.inviteUrl.text!, self.imageCode.bounds.width)
            }
        } failure: { (error) in
            
        }

    }
    @IBAction func copyAction(_ sender: UIButton) {
        let pastboard = UIPasteboard.general
        
        if sender.tag == 10 {//拷贝邀请地址
            pastboard.string = inviteUrl.text
        }else{
            pastboard.string = inviteCode.text
        }
        self.view.makeToast("复制成功".localized)
    }
    
    @IBAction func checkInviteListAction(_ sender: UITapGestureRecognizer) {
        let invite = LSInviteListViewController()
        self.navigationController?.pushViewController(invite, animated: true)
    }
}
extension LSInviteViewController{
    //生成二维码
    func loadQRcode(with string: String,_ size:CGFloat) -> UIImage? {
        //1.将字符串转出NSData
        let data = string.data(using: .utf8)
        //2.将字符串变成二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        //3.恢复滤镜的默认属性
        filter?.setDefaults()
        //4.设置滤镜的 inputMessage
        filter?.setValue(data, forKey: "inputMessage")
        
        guard let image = filter?.outputImage else{
            return nil
        }
        let extent = image.extent
        
        let scale = min(size/extent.width, size/extent.height)
        
        let scaleImage = image.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        return UIImage.init(ciImage: scaleImage)
    }
}
