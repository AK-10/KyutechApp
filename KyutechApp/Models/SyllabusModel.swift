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
                onError()
            } else {
                let status = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value as? Parameters else { print("data is nil"); return }
                    let results = resData["results"] as! [Parameters]
                    var syllabuses: [Syllabus] = results.map { (item) -> Syllabus in
                        let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                        return try! JSONDecoder().decode(Syllabus.self, from: itemData)
                    }
//                    一時的な処理, あとで直す
                    if let nextURL = resData["next"] as? String {
                        Alamofire.request(nextURL).responseJSON(completionHandler: { res in
                            if let err = res.error {
                                print(err)
                                onError()
                            } else {
                                let status = res.response?.statusCode ?? -1
                                if status >= 200 && status < 300 {
                                    guard let nextData = res.value as? Parameters else { return }
                                    let nextResults = nextData["results"] as! [Parameters]
                                    let nextSyllabuses: [Syllabus] = nextResults.map { (item) -> Syllabus in
                                        let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                                        return try! JSONDecoder().decode(Syllabus.self, from: itemData)
                                    }
                                    syllabuses.append(contentsOf: nextSyllabuses)
                                    print(syllabuses.count)
                                    onSuccess(syllabuses)
                                } else {
                                    onError()
                                }
                            }
                        })
                    } else {
                        print(syllabuses.count)
                        onSuccess(syllabuses)
                    }
                } else {
                    print("Error: status is Invalid")
                    onError()
                }
            }
        })
    }

}


