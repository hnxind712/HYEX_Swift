//
//  Number+Extension.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/18.
//

import Foundation

extension Double{
    func numberStringDontFillZero(with decimal: Int16) -> String {
        guard self > 0 else {
            return "0.00"
        }
        let orDecimal: NSDecimalNumber = NSDecimalNumber.init(value: self)
        
        let roundingBehavior: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.down, scale: decimal, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let transfer = orDecimal.rounding(accordingToBehavior: roundingBehavior)
        
        return String(format: "%@", transfer)
    }
}
