//
//  LSFeedBackRecordCell.swift
//  HYEX_Swift
//
//  Created by heyong on 2021/3/11.
//

import UIKit

class LSFeedBackRecordCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var replyView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var model: LSFeedBackModel!{
        didSet{
            if let message = model.message {
                title.text = "\(message)"
            }
            if let _time = model.createTime {
                time.text = String(describing: _time.self)
            }
            if let content = model.responseMessage {
                replyView.isHidden = false
                message.text = content
            }else{
                replyView.isHidden = true
            }
        }
    }
}
