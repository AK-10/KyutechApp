//
//  UserModel.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/15.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

class UserModel {
    class func createUser(year: Int, depart: Int, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        let params: Parameters =
            ["school_year":year, "department":depart]
        
        Alamofire.request(Router.createUser(params: params)).responseJSON(completionHandler: { res in
            if let error = res.error {
                print(error)
                onError()
            } else {
                let status: Int = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value else {
                        print("data is nil")
                        onError()
                        return
                    }
                    let dict = resData as! Parameters
                    UserDefaults.standard.set(dict["id"] as! Int, forKey: .primaryKey)
                    UserDefaults.standard.set(dict["school_year"] as! Int, forKey: .schoolYear)
                    UserDefaults.standard.set(dict["department"] as! Int, forKey: .department)
                    onSuccess()
                } else {
                    print("Error because status is invalid")
                    onError()
                }
            }
        })
    }
    
    class func updateUser(year: Int, depart: Int, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        let params: Parameters = ["school_year": year,
                                  "department": depart ]
        guard let id = UserDefaults.standard.int(forKey: .primaryKey) else { return }
        Alamofire.request(Router.updateUser(id: id, params: params)).responseJSON(completionHandler: { res in
            if let err = res.error {
                print("Error: \(err)")
            } else {
                let status = res.response?.statusCode ?? -1
                print("statusCode: \(status)")
                if status >= 200 && status < 300 {
                    guard let resData = res.value else {
                        print("data is nil")
                        onError()
                        return
                    }
                    let dict = resData as! Parameters
                    UserDefaults.standard.set(dict["school_year"] as! Int, forKey: .schoolYear)
                    UserDefaults.standard.set(dict["department"] as! Int, forKey: .department)
                    onSuccess()
                } else {
                    onError()
                }
            }
        })
        
    }
}
