//
//  String+Extension.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/2/22.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
