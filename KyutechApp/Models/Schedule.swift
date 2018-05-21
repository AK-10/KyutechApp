//
//  Schedule.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/21.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    let title: String
    let subjectCode: Int
    let teacherName: String
    struct TargetParticipantsInfo: Codable {
        let targetParticipants: String
        let academicCreditKind: String
        let academicCreditNum: Int
        
        private enum CodingKeys: String, CodingKey {
            case targetParticipants = "target_participants"
            case academicCreditKind = "academic_credit_kind"
            case academicCreditNum = "academic_credit_num"
        }
    }
    let targetParticipantsInfos: [TargetParticipantsInfo]
    let targetSchoolYear: String
    let classNumber: Int
    let targetPeriod: String
    let publishedDate: String
    let abstract: String
    let positioning: String
}
