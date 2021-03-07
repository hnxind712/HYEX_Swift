//
//  LSVerifyCodeBtn.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/25.
//

import UIKit

class LSVerifyCodeBtn: UIButton {
    var timeInterval: Int = 60
    let timeSource = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue:DispatchQueue.global())
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initTimeSource()
    }
     required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initTimeSource()
    }
    func initTimeSource() {
        timeSource.schedule(deadline: .now(), repeating: .milliseconds(1000))
        timeSource.setEventHandler {
            self.timeInterval -= 1
            if self.timeInterval <= 0 {
                DispatchQueue.main.async {
                    self.setTitle("获取验证码", for: .normal)
                }
                self.timeSource.cancel()
            }else{
                DispatchQueue.main.async {
                    self.setTitle("\(self.timeInterval)s", for: .normal)
                }
            }
        }
    }
    //测试用
    func testFunc() {
        self.timeSource.resume()
    }
    func sendMessageVerifyCodeAction(_ params:[String : Any]) {
        LSNetRequest.sharedInstance.postRequest(KMessageValidateCode, params: params) { (response) in
            self.timeSource.resume()
        } failure: { (error) in
            
        }

    }
}
