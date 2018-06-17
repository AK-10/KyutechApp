//
//  ScheduleModel.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/21.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

class SyllabusModel {
    class func readSyllabusWith(day: String, period: Int, onSuccess: @escaping ([Syllabus]) -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.readSyllabusWith(dayID: day, periodID: period)).responseJSON(completionHandler: { res in
            if let err = res.error {
                print("Error: \(err)")
            } else {
                let status = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value else { print("data is nil"); return }
                    let dataDict = resData as! Parameters
                    let results = dataDict["results"] as! [Parameters]
                    let syllabuses: [Syllabus] = results.map {
                        (item) -> Syllabus in
                        let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                        return try! JSONDecoder().decode(Syllabus.self, from: itemData)
                    }
                    print(syllabuses)
                    onSuccess(syllabuses)
                } else {
                    print("Error: status is Invalid")
                }
            }
        })
    }
}


