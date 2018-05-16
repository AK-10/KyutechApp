//
//  News.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

class News {
    var infos: [[String:String]]
    var attachmentInfos: [[String:String]]?
    
    init(infos: [[String:String]], attachmentInfos: [[String:String]]?) {
        self.infos = infos
        self.attachmentInfos = attachmentInfos
    }
    
    private enum CodingKeys: String, CodingKey {
        case attachmentInfos = "attachment_infos"
    }

}
