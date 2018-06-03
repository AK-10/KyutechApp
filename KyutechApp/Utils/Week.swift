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
    
    static func from(hash: Int) -> Week {
        switch hash {
        case 0:
            return self.monday
        case 1:
            return self.tuesday
        case 2:
            return self.wednesday
        case 3:
            return self.thursday
        case 4:
            return self.friday
        default:
            return self.init(rawValue: "Error")!
        }
    }
    
    func ja() -> String {
        switch self {
        case .monday:
            return "月曜"
        case .tuesday:
            return "火曜"
        case .wednesday:
            return "水曜"
        case .thursday:
            return "木曜"
        case .friday:
            return "金曜"
        }
    }

}
