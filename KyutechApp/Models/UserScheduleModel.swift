//
//  UserScheduleModel.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

class UserScheduleModel {
    
    class func getSchedule(userId: Int, quarter: Int, onSuccess: @escaping ([UserSchedule]) -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.readSchedule(id: userId, quarter: quarter)).responseJSON(completionHandler: { res in
            if let err = res.error {
                print("Error: \(err)")
                onError()
            } else {
                let status = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value else { return }
                    let dataDict = resData as! Parameters
                    let results = dataDict["results"] as! [Parameters]
                    let userSchedules: [UserSchedule] = results.map{ (item) -> UserSchedule in
                        let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                        return try! JSONDecoder().decode(UserSchedule.self, from: itemData)
                    }
                    onSuccess(userSchedules)
                } else {
                    print("Error: \(res.value!)")
                    onError()
                }
            }
        })
    }
    
    class func createSchedule(syllabusId: Int, day: Int, period: Int, quarter: Int, onSuccess: @escaping (UserSchedule) -> Void, onError: @escaping () -> Void) {
        guard let userId = UserDefaults.standard.int(forKey: .primaryKey) else { return }
        let params: Parameters = [
            "user_id":userId,
            "syllabus_id":syllabusId,
            "day":day,
            "period":period,
            "quarter":quarter,
            "memo":"",
            "late_num":0,
            "absent_num":0
        ]
        
        Alamofire.request(Router.createSchedule(params: params)).responseJSON(completionHandler: { res in
            if let err = res.error {
                print("Error: \(err)")
                onError()
            } else {
                let status = res.response?.statusCode ?? -1
                print("StatusCode: \(status)")
                if status >= 200 && status < 300 {
                    guard let dataDict = res.value else { return }
                    print("type of res.value \(type(of: dataDict))")
                    let data = try! JSONSerialization.data(withJSONObject: dataDict, options: [])
                    let userSchedule = try! JSONDecoder().decode(UserSchedule.self, from: data)
                    onSuccess(userSchedule)
                } else {
                    print("statusCode: \(status)")
                    let data: Data = try! JSONSerialization.data(withJSONObject: res.value!, options: [])

                    print("res.value: \(String(bytes: data, encoding: .utf8) ?? "nil")")
                    onError()
                }
            }
        })
    }
    
    class func updateUserSchedule(syllabusId: Int, day: Int, period: Int, quarter: Int, late: Int, absent: Int, memo: String, onSuccess: @escaping (UserSchedule) -> Void, onError: @escaping () -> Void) {
        guard let userId = UserDefaults.standard.int(forKey: .primaryKey) else { return }
        let params: Parameters = [
            "user_id":userId,
            "syllabus_id":syllabusId,
            "day":day,
            "period":period,
            "quarter":quarter,
            "memo":memo,
            "late_num":late,
            "absent_num":absent
        ]
        print(params)
        Alamofire.request(Router.updateSchedule(params: params)).responseJSON(completionHandler: { res in
            if let err = res.error {
                print(err)
                onError()
            } else {
                let status = res.response?.statusCode ?? -1
                print("StatusCode: \(status)")
                if status >= 200 && status < 300 {
                    guard let dataDict = res.value else { return }
                    print("type of res.value \(type(of: dataDict))")
                    let data = try! JSONSerialization.data(withJSONObject: dataDict, options: [])
                    let userSchedule = try! JSONDecoder().decode(UserSchedule.self, from: data)
                    onSuccess(userSchedule)
                } else {
                    onError()
                    print(String(bytes: res.data!, encoding: .utf8)!)
                }
            }
        })
    }
    
    class func deleteSchedule(scheduleId: Int, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.deleteSchedule(id: scheduleId)).response(completionHandler: { res in
            if let err = res.error {
                print(err)
            } else {
                if res.response?.statusCode == 204 {
                    onSuccess()
                } else {
                    onError()
                }
            }
        })
    }
}
