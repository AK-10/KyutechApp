//
//  Common.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class func extendedInit(from hex: String) -> UIColor? {
        let pattern = "[#+]"
        let colorCode = hex.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
        if colorCode.count != 6 {
            return nil
        } else {
            
            let red = CGFloat(Int(String(colorCode[colorCode.startIndex...colorCode.index(colorCode.startIndex, offsetBy: 1)]), radix: 16)!) / 255
            let green = CGFloat(Int(String(colorCode[colorCode.index(colorCode.startIndex, offsetBy: 2)...colorCode.index(colorCode.startIndex, offsetBy: 3)]), radix: 16)!) / 255
            let blue = CGFloat(Int(String(colorCode[colorCode.index(colorCode.startIndex, offsetBy: 4)..<colorCode.endIndex]), radix: 16)!) / 255
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}
