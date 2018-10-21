//
//  UserInfomationEnum.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/19.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

enum SchoolYear: Int {
    case bachelorOne
    case bachelorTwo
    case bachelorThree
    case bachelorFour
    case masterOne
    case mansterTwo
    
    func ja() -> String {
        switch self {
        case .bachelorOne:
            return "学部1年"
        case .bachelorTwo:
            return "学部2年"
        case .bachelorThree:
            return "学部3年"
        case .bachelorFour:
            return "学部4年"
        case .masterOne:
            return "修士1年"
        case .mansterTwo:
            return "修士2年"
        }
    }
    
    static func from(rawValue: Int) -> SchoolYear {
        switch rawValue {
        case 0:
            return .bachelorOne
        case 1:
            return .bachelorTwo
        case 2:
            return .bachelorThree
        case 3:
            return .bachelorFour
        case 4:
            return .masterOne
        case 5:
            return .mansterTwo
        default:
            return SchoolYear.init(rawValue: -1)!
        }
    }
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
    case infomationCreation
    case advancedInfoAI
    case advancedInfoCSE
    case interdisciplinarySYS
    case interdisciplinaryBIO
    case interdisciplinaryMSE
    
    static func from(hash: Int) -> Department {
        switch hash {
        case 0:
            return .classI_I
        case 1:
            return .classI_II
        case 2:
            return .classII_III
        case 3:
            return .classIII_IV
        case 4:
            return .classIII_V
        case 5:
            return .ai
        case 6:
            return .aiIncorp
        case 7:
            return .cse
        case 8:
            return .cseIncorp
        case 9:
            return .mse
        case 10:
            return .mseIncorp
        case 11:
            return .bio
        case 12:
            return .bioIncorp
        case 13:
            return .sys
        case 14:
            return .sysIncorp
        case 15:
            return .infomationCreation
        case 16:
            return .advancedInfoAI
        case 17:
            return .advancedInfoCSE
        case 18:
            return .interdisciplinarySYS
        case 19:
            return .interdisciplinaryBIO
        case 20:
            return .interdisciplinaryMSE
        default:
            return Department.init(rawValue: -1)!
        }
    }
    
    func value() -> Int {
        return self.rawValue + 200
    }
    
    func ja() -> String {
        switch self {
        case .classI_I:
            return "情工１類　Ⅰクラス"
        case .classI_II:
            return "情工１類　Ⅱクラス"
        case .classII_III:
            return "情工２類　Ⅲクラス"
        case .classIII_IV:
            return "情工３類　Ⅳクラス"
        case .classIII_V:
            return "情工３類　Ⅴクラス"
        case .ai:
            return "知能情報工学科"
        case .aiIncorp:
            return "知能情報工学科（編入）"
        case .cse:
            return "電子情報工学科"
        case .cseIncorp:
            return "電子情報工学科（編入）"
        case .sys:
            return "システム創成情報工学科"
        case .sysIncorp:
            return "システム創成情報工学科（編入）"
        case .mse:
            return "機械情報工学科"
        case .mseIncorp:
            return "機械情報工学科（編入）"
        case .bio:
            return "生命情報工学科"
        case .bioIncorp:
            return "生命情報工学科（編入）"
        case .infomationCreation:
            return "情報創成工学専門分野"
        case .advancedInfoAI:
            return "知能情報工学専門分野"
        case .advancedInfoCSE:
            return "電子情報工学専門分野"
        case .interdisciplinarySYS:
            return "システム創成情報工学専門分野"
        case .interdisciplinaryBIO:
            return "生命情報工学専門分野"
        case .interdisciplinaryMSE:
            return "機械情報工学専門分野"
        }
    }
}
