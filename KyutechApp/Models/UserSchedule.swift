//
//  UserSchedule.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct UserSchedule: Codable {
    let id: Int
    let syllabus: Syllabus
    let day: Int
    let period: Int
    let quarter: Int
    let memo: String
    let lateNum: Int?
    let absentNum: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case syllabus
        case day
        case period
        case quarter
        case memo
        case lateNum = "late_num"
        case absentNum = "absent_num"
    }
    
    func indexFrom() -> Int {
        return period*5 + day
    }
}
