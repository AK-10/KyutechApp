//
//  UserSchedule.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct UserSchedule: Codable {
    let syllabus: Syllabus
    let day: Int
    let period: Int
    let quarter: Int
    let memo: String
    let lateNum: Int?
    let absentNum: Int?
    
    func indexFrom() -> Int {
        return period*5 + day
    }
}
