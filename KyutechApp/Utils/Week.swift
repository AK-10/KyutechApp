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
    
    static func from(index: Int) -> Week {
        switch index {
        case 0:
            return .monday
        case 1:
            return .tuesday
        case 2:
            return .wednesday
        case 3:
            return .thursday
        case 4:
            return .friday
        default:
            return Week.init(rawValue: "Error")!
        }
    }

    func index() -> Int {
        switch self {
        case .monday:
            return 0
        case .tuesday:
            return 1
        case .wednesday:
            return 2
        case .thursday:
            return 3
        case .friday:
            return 4
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
