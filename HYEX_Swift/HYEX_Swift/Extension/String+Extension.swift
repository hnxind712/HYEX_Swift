//
//  String+Extension.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    // MARK: 获取字符串高度
    func height(with size: CGSize,_ attribute: [NSAttributedString.Key: Any]) -> CGFloat {
        let maxSize = (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: attribute, context: nil).size
        return maxSize.height
    }
    // MARK: 时间字符串转换
    func timeTransition(formatter:String) -> String {
        guard self.count > 0 else {
            return ""
        }
        let currentFormatter = DateFormatter()
        currentFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = currentFormatter.date(from: self)
        
        let transitionFormater = DateFormatter()
        transitionFormater.dateFormat = formatter
        let transitionString = transitionFormater.string(from: date!)
        return transitionString
    }
}
