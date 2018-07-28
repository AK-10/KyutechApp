//
//  Datas.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct Const {
    static let serverURL: String = "https://kyutechapp2018.planningdev.com/api"
    static let webPageLinks: [(String, String)] = [("ユーザー情報の変更",""),
                                                   ("P&Dについて", "https://www.planningdev.com/"),
                                                   ("要望フォーム","https://docs.google.com/forms/d/e/1FAIpQLSeBqDZ8OTsuOjFnniTIxSrNq6phAZ22dt95bCC1w-lV6VPZ9Q/viewform"),
                                                   ("九工大飯塚キャンパスホームページ", "https://www.iizuka.kyutech.ac.jp/"),
                                                   ("九工大シラバス","https://edragon-syllabus.jimu.kyutech.ac.jp/guest/syllabuses"),
                                                   ("九工大moodle","https://ict-i.el.kyutech.ac.jp/"),
                                                   ("九工大ライブキャンパス", "https://virginia.jimu.kyutech.ac.jp/portal/init.do?userDivision=2&locale=ja") ]
    
    static let departments: [Department] = [Department.classI_I, Department.classI_II, Department.classII_III, Department.classIII_IV, Department.classIII_V, Department.ai, Department.aiIncorp, Department.cse, Department.cseIncorp, Department.mse, Department.mseIncorp, Department.bio, Department.bioIncorp, Department.sys, Department.sysIncorp]
    
    static let years: [Int] = [SchoolYearKey.one.rawValue, SchoolYearKey.two.rawValue, SchoolYearKey.three.rawValue, SchoolYearKey.four.rawValue]
    
    static let syllabusItemHeaders = ["授業名", "科目コード", "担当教員", "学科別情報", "対象学年", "クラス", "曜日・時限", "講義室", "開講学期", "更新日", "概要", "カリキュラムにおける授業の立ち位置", "授業項目", "授業の進め方", "授業の達成目標", "成績評価の基準および評価方法", "授業外学習（予習・復習）の指示", "キーワード", "教科書", "参考書", "備考", "メールアドレス"]
}
