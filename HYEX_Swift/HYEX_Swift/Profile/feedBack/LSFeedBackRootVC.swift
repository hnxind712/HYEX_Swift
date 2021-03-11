//
//  LSFeedBackRootVC.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/11.
//

import UIKit
import SnapKit


class LSFeedBackRootVC: LSBaseViewController {

    @IBOutlet weak var functionView: UIView!
    var selectedBtn: UIButton!
    var currentViewController: LSBaseViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "反馈".localized
        
        selectedBtn = self.view.viewWithTag(10) as? UIButton
        
        addChildController()

    }
    func addChildController(){
        let feedback = LSFeedBackViewController()
        self.addChild(feedback)
        
        let feedbackRecord = LSFeedBackRecordVC()
        self.addChild(feedbackRecord)
        
        currentViewController = feedback
        self.view.addSubview(currentViewController!.view)
        feedback.view.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.functionView.snp_bottom)
            maker.left.right.bottom.equalToSuperview()
        }
    }
    @IBAction func showFeedBackAction(_ sender: UIButton) {
        guard selectedBtn != sender else {
            return
        }
        selectedBtn.isSelected = false
        selectedBtn.backgroundColor = HEXCOLOR(h: 0xffffff, alpha: 1)
        sender.isSelected = true
        sender.backgroundColor = HEXCOLOR(h: 0x3078F7, alpha: 1)
        selectedBtn = sender
        
        //切换视图
        currentViewController?.view.removeFromSuperview()
        currentViewController = self.children.first! as? LSBaseViewController
        self.view.addSubview(currentViewController!.view)
        currentViewController?.view.snp.makeConstraints{ (maker) in
            maker.top.equalTo(self.functionView.snp_bottom)
            maker.left.right.bottom.equalToSuperview()
        }
    }
    @IBAction func showFeedBackRecordAction(_ sender: UIButton) {
        guard selectedBtn != sender else {
            return
        }
        selectedBtn.isSelected = false
        selectedBtn.backgroundColor = HEXCOLOR(h: 0xffffff, alpha: 1)
        sender.isSelected = true
        sender.backgroundColor = HEXCOLOR(h: 0x3078F7, alpha: 1)
        selectedBtn = sender
        
        //切换视图
        currentViewController?.view.removeFromSuperview()
        currentViewController = self.children.last! as? LSBaseViewController
        self.view.addSubview(currentViewController!.view)
        currentViewController?.view.snp.makeConstraints{ (maker) in
            maker.top.equalTo(self.functionView.snp_bottom)
            maker.left.right.bottom.equalToSuperview()
        }
    }


}
