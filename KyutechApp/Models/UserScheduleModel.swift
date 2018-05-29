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
    
    class func getSchedule(userId: Int, quarter: Int) {
        Alamofire.request(Router.readSchedule(id: userId, quarter: quarter)).responseJSON
    }
}
