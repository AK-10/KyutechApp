//
//  Schedule.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/21.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation



struct Syllabus: Codable {
    
    static let keys = ["授業名", "科目コード", "担当教員", "学科別情報", "対象学年", "クラス", "曜日・時限", "開講学期", "更新日", "概要", "カリキュラムにおける授業の立ち位置", "授業項目", "授業の進め方", "授業の達成目標", "成績評価の基準および評価方法", "授業外学習（予習・復習）の指示", "キーワード", "教科書", "参考書", "備考", "メールアドレス"]
    
    let title: String
    let subjectCode: Int
    let teacherName: String
    
    struct TargetParticipantsInfo: Codable {
        let targetParticipants: String
        let academicCreditKind: String
        let academicCreditNum: Float
        
        enum CodingKeys: String, CodingKey {
            case targetParticipants = "target_participants"
            case academicCreditKind = "academic_credit_kind"
            case academicCreditNum = "academic_credit_num"
        }
        
        private func JSONencode() -> Data? {
            do {
                let encoder = JSONEncoder()
                return try encoder.encode(self)
            } catch {
                print("Error")
                return nil
            }
        }
        
        func description() -> String {
            let participants = "学科: \(targetParticipants)"
            let creditKind = "単位区分: \(academicCreditKind)"
            let creditNum = "単位数: \(academicCreditNum)"
            return participants + "\n" + creditKind + "\n" + creditNum
        }
        
        
    }
    let targetParticipantsInfos: [TargetParticipantsInfo]
    let targetSchoolYear: String
    let classNumber: Int
    let targetPeriod: String
    let targetTerm: String
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
        case targetTerm = "target_term"
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
//
//    func encode(to encoder: Encoder) {
//        var container = encoder.container(keyedBy: TargetParticipantsInfo.CodingKeys.self)
//
//    }
    
    private func JSONencode() -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            print("Error")
            return nil
        }
    }

    func dictionary() -> [String:Any]? {
        guard let data = self.JSONencode() else { return nil }
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        let dict = json as! [String:AnyObject]
        return dict
    }
    
    func prettyPrint() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            print(String(data: try encoder.encode(self), encoding: .utf8)!)
        } catch {
            print("can't print")
        }
    }
    
    func values(key: String) -> [String] {
        switch key {
        case "授業名":
            return [title]
        case "科目コード":
            return [subjectCode.description]
        case "担当教員":
            return [teacherName]
        case "学科別情報":
            return targetParticipantsInfos.map { return $0.description() }
        case "対象学年":
            return [targetSchoolYear]
        case "クラス":
            return [classNumber.description]
        case "曜日・時限":
            return [targetPeriod]
        case "開講学期":
            return [targetTerm]
        case "更新日":
            return [publishedDate]
        case "概要":
            return [abstract]
        case "カリキュラムにおける授業の立ち位置":
            return [positioning]
        case "授業項目":
            return [lectureContent]
        case "授業の進め方":
            return [lectureProcessing]
        case "授業の達成目標":
            return [performanceTarget]
        case "成績評価の基準および評価方法":
            return [valuationBasis]
        case "授業外学習（予習・復習）の指示":
            return [instructionOutLearning]
        case "キーワード":
            return [keywords]
        case "教科書":
            return [textBooks]
        case "参考書":
            return [studyAidBooks]
        case "備考":
            return [notes]
        case "メールアドレス":
            return [professorEmail]
        default:
            return []
        }
    }
    
    func getQuarterCodes() -> [Int] {
        switch targetTerm {
        case "前期":
            return [0,1]
        case "後期":
            return [2,3]
        case "第1クォーター":
            return [0]
        case "第2クォーター":
            return [1]
        case "第3クォーター":
            return [2]
        case "第4クォーター":
            return [3]
        case "集中講義", "通年":
            return [0,1,2,3]
        default:
            return []
        }
    }
    
}
