//
//  UserInfomationEnum.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/19.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

enum SchoolYearKey: Int {
    case one
    case two
    case three
    case four
}

enum Department: Int {
    case classI_I
    case classI_II
    case classII_III
    case classIII_IV
    case classIII_V
    case ai
    case aiIncorp
    case cse
    case cseIncorp
    case mse
    case mseIncorp
    case bio
    case bioIncorp
    case sys
    case sysIncorp
    
    func value() -> Int{
        return self.rawValue + 200
    }
    
    func ja() -> String {
        switch self {
        case .classI_I:
            return "情工１類 Ⅰクラス"
        case .classI_II:
            return "情工１類 Ⅱクラス"
        case .classII_III:
            return "情工２類 Ⅲクラス"
        case .classIII_IV:
            return "情工３類　Ⅳクラス"
        case .classIII_V:
            return "情工３類　Ⅴクラス"
        case .ai:
            return "知能"
        case .aiIncorp:
            return "知能(編入)"
        case .cse:
            return "電子"
        case .cseIncorp:
            return "電子(編入)"
        case .mse:
            return "機械"
        case .mseIncorp:
            return "機械(編入)"
        case .bio:
            return "生命"
        case .bioIncorp:
            return "生命(編入)"
        case .sys:
            return "システム"
        case .sysIncorp:
            return "システム(編入)"
        }
    }
}
