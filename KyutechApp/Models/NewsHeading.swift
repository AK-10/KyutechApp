//
//  NewsHeading.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation


struct NewsHeading: Codable {
    var newsHeadingCode: Int
    var shortName: String
    var name: String
    var colorCode: String
    var updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case newsHeadingCode = "news_heading_code"
        case shortName = "short_name"
        case name = "name"
        case colorCode = "color_code"
        case updatedAt = "updated_at"
    }
}
