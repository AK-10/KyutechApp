//
//  Schedule.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/21.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct Syllabus: Codable {
    let title: String
    let subjectCode: Int
    let teacherName: String
    struct TargetParticipantsInfo: Codable {
        let targetParticipants: String
        let academicCreditKind: String
        let academicCreditNum: Float
        
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
    let lectureContent: String
    let lectureProcessing: String
    let performanceTarget: String
    let valuationBasis: String
    let instructionOutLearning: String
    let keywords: String
    let textBooks: String
    let studyAidBooks: String
    let notes: String
    let professorEmail: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case subjectCode = "subject_code"
        case teacherName = "teacher_name"
        case targetParticipantsInfos = "target_participants_infos"
        case targetSchoolYear = "target_school_year"
        case classNumber = "class_number"
        case targetPeriod = "target_period"
        case publishedDate = "published_date"
        case abstract = "abstract"
        case positioning = "positioning"
        case lectureContent = "lecture_content"
        case lectureProcessing = "lecture_processing"
        case performanceTarget = "performance_target"
        case valuationBasis = "valuation_basis"
        case instructionOutLearning = "instruction_out_learning"
        case keywords = "keywords"
        case textBooks = "text_books"
        case studyAidBooks = "study_aid_books"
        case notes = "notes"
        case professorEmail = "professor_email"
    }
}
