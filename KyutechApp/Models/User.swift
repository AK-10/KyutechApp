//
//  User.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/17.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let schoolYear: Int
    let department: Int
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case schoolYear = "school_year"
        case department
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func writeUserDefaults() {
        UserDefaults.standard.set(id, forKey: .primaryKey)
        UserDefaults.standard.set(schoolYear, forKey: .schoolYear)
        UserDefaults.standard.set(department, forKey: .department)
    }
}
