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
    class func createUser(params: Parameters, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.createUser(params: params)).responseJSON(completionHandler: { res in
            
        })
    }
    
    class func updateUser() {
        
    }
}
