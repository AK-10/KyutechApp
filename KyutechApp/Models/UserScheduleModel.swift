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
                    print("Error: status is Invalid")
                    onError()
                }
            }
        })
    }
}
