//
//  LSProfileHeaderView.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/10.
//

import UIKit
import Kingfisher

class LSProfileHeaderView: UIView {

    @IBOutlet weak var cornerBgView: UIView!
    @IBOutlet weak var headPortrait: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var inviteId: UILabel!
    
    
    static func profileHeaderView() -> LSProfileHeaderView?{
        let headerView = Bundle.main.loadNibNamed(String(describing: LSProfileHeaderView.self), owner: nil, options: nil)
        if let view = headerView?.first as? LSProfileHeaderView {
            view.backgroundColor = UIColor(patternImage: UIImage.gradientImage(size: view.bounds.size, colors: [HEXCOLOR(h: 0x3685F9, alpha: 1),HEXCOLOR(h: 0x5E2CEF, alpha: 1)], gradientType: .LeftTopToRightBottom))
            view.cornerBgView.viewCornerRadius(CGSize(width: 10, height: 10), [UIRectCorner.topLeft,UIRectCorner.topRight])
            return view
        }
        return nil
    }

    func reloadHeaderView() {//直接拿userModel处理数据即可
        let userInfo: LSUserInfo = LSUserInfo.sharedInstance()!
        
        if let headerUrl = userInfo.headUrl {
            self.headPortrait.kf.setImage(with: ImageResource(downloadURL: NSURL(string: headerUrl)! as URL))
        }else{
            self.headPortrait.image = UIImage(named: "icon_trader_avatar_default")
        }
        self.inviteId.text = userInfo.inviteCode
        //处理nickName
        var location = 4
        
        if let range = userInfo.userName?.range(of: "@") {
            let _nsRange = NSRange(range,in: "@")
            location = userInfo.userName!.count - _nsRange.location
        }
        let length = userInfo.userName!.count - 3 - location
        if length > 0 {
            var string = ""
            for _ in 0 ..< length {
                string.append("*")
            }
            let _string: NSString = userInfo.userName! as NSString
            let text = _string.replacingCharacters(in: NSMakeRange(3, length), with: string)
            userName.text = text
        }else{
            userName.text = userInfo.userName
        }
        
    }
    
    var shareBlock:(()->())?
    
    @IBAction func shareAction(_ sender: UIButton) {
        if let block = shareBlock {
            block()
        }
    }
}
