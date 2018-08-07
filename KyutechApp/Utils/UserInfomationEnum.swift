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
//    case advancedInfomatics
//    case interdisciplinaryInformatics
//    case creativeInformatics
    
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
//        case 15:
//            return .advancedInfomatics
//        case 16:
//            return .interdisciplinaryInformatics
//        case 17:
//            return .creativeInformatics
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
//        case .advancedInfomatics:
//            return "先端情報工学専攻"
//        case .interdisciplinaryInformatics:
//            return "学際情報工学専攻"
//        case .creativeInformatics:
//            return "情報創生工学専攻"
        }
    }
}
