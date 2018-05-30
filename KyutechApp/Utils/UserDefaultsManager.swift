//
//  UserDefaultsManager.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/19.
//  Copyright © 2018年 小西篤志. All rights reserved.
//


// UserDefaultsのkeyを .~ の形で使えるようにするためのもの
import Foundation

protocol KeyNameSpaceable {
    func nameSpaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNameSpaceable {
    func nameSpaced<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}

protocol StringDefaultSettable: KeyNameSpaceable {
    associatedtype StringKey: RawRepresentable
}

extension StringDefaultSettable where StringKey.RawValue == String {
    func set(_ value: String, forKey key: StringKey) {
        let key = nameSpaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func set(_ value: Int, forKey key: StringKey) {
        let key = nameSpaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    @discardableResult
    func string(forKey key: StringKey) -> String? {
        let key = nameSpaced(key)
        return UserDefaults.standard.string(forKey: key)
    }
    
    @discardableResult
    func int(forKey key: StringKey) -> Int? {
        let key = nameSpaced(key)
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func removeObject(forKey key: StringKey) {
        let key = nameSpaced(key)
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension UserDefaults: StringDefaultSettable {
    enum StringKey: String {
        case primaryKey
        case schoolYear
        case department
    }
}
