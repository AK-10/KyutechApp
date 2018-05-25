//
//  Week.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/22.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

enum Week: String {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    
    static func toRawFrom(hash: Int) -> String {
        switch hash {
        case 0:
            return Week.monday.rawValue
        case 1:
            return Week.tuesday.rawValue
        case 2:
            return Week.wednesday.rawValue
        case 3:
            return Week.thursday.rawValue
        case 4:
            return Week.friday.rawValue
        default:
            return "Error"
        }
    }
}
