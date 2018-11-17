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
    static var isLoading = false
    static var nextURL: String? = nil
    
    class func readSyllabusWith(day: String, period: Int, onSuccess: @escaping ([Syllabus]) -> Void, onError: @escaping () -> Void) {
        if !isLoading {
            isLoading = true
            Alamofire.request(Router.readSyllabusWith(dayID: day, periodID: period)).responseJSON(completionHandler: { res in
                if let err = res.error {
                    print("Error: \(err)")
                    onError()
                } else {
                    let status = res.response?.statusCode ?? -1
                    if status >= 200 && status < 300 {
                        guard let resData = res.value as? Parameters else { print("data is nil"); return }
                        nextURL = resData["next"] as? String
                        let results = resData["results"] as! [Parameters]
                        let syllabuses: [Syllabus] = results.map { (item) -> Syllabus in
                            let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                            return try! JSONDecoder().decode(Syllabus.self, from: itemData)
                        }
                        onSuccess(syllabuses)
                        isLoading = false
                    } else {
                        print("Error: status is Invalid")
                        onError()
                        isLoading = false
                    }
                }
            })
        }
    }
    
    
    class func fetchSyllabuses(onSuccess: @escaping ([Syllabus]) -> Void, onError: @escaping () -> Void, completion: (() -> Void)?) {
        guard let next = nextURL else {
            isLoading = false
            if let unwrappedCompletion = completion {
                unwrappedCompletion()
            }
            return
        }
        if !isLoading {
            isLoading = true
            print(next)
            Alamofire.request(next).responseJSON(completionHandler: { res in
                if res.error != nil {
                    onError()
                    isLoading = false
                    if let unwrappedCompletion = completion {
                        unwrappedCompletion()
                    }
                    print("error: response is nil")
                } else {
                    let status = res.response?.statusCode ?? -1
                    if status >= 200 && status < 300 {
                        guard let resData = res.value as? Parameters else { print("data is nil"); return }
                        nextURL = resData["next"] as? String
                        let results = resData["results"] as! [Parameters]
                        let syllabuses: [Syllabus] = results.map { (item) -> Syllabus in
                            let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                            return try! JSONDecoder().decode(Syllabus.self, from: itemData)
                        }
                        isLoading = false
                        onSuccess(syllabuses)
                        if let unwrappedCompletion = completion {
                            unwrappedCompletion()
                        }
                    } else {
                        print("Error: status is Invalid")
                        isLoading = false
                        onError()
                        if let unwrappedCompletion = completion {
                            unwrappedCompletion()
                        }
                    }
                }
            })
        }
    }

}


