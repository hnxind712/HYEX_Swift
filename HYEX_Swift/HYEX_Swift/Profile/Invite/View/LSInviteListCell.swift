//
//  LSInviteListCell.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/12.
//

import UIKit

class LSInviteListCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var model:LSInviteListModel! {
        didSet{
            //处理nickName
            var location = 4
            
            if let range = model.userName?.range(of: "@") {
                let _nsRange = NSRange(range,in: "@")
                location = model.userName!.count - _nsRange.location
            }
            let length = model.userName!.count - 3 - location
            if length > 0 {
                var string = ""
                for _ in 0 ..< length {
                    string.append("*")
                }
                let _string: NSString = model.userName! as NSString
                let text = _string.replacingCharacters(in: NSMakeRange(3, length), with: string)
                userName.text = text
            }else{
                userName.text = model.userName
            }
            if let tradeFeeConversion = model.tradeFeeConversion {
                self.amount.text = String(format: "%.2f USDT", tradeFeeConversion)
            }else{
                self.amount.text = "0.00"
            }
            
            self.time.text = model.registerTime?.timeTransition(formatter: "HH-mm dd/MM/yyyy")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
