//
//  Router.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString: String = "https://kyutechapp2018.planningdev.com/api"
//    static let baseURLString: String = "http://localhost:8000/api"
    
    case createUser(params: Parameters)
    case readUser(id: Int)
    case updateUser(id: Int, params: Parameters)
    
    case readNewsHeadings()
    case readNews(id: Int)
    
    case readSyllabusDetails(id: Int)
    case readSyllabusWith(dayID: String, periodID: Int)
    
    case createSchedule(params: Parameters)
    case updateSchedule(id: Int, params: Parameters)
    case readSchedule(id: Int, quarter: Int)
    case deleteSchedule(id: Int)
    
    var method: HTTPMethod {
        switch self {
            
        case .createUser:
            return .post
        case .readUser:
            return .get
        case .updateUser:
            return .put
        case .readNewsHeadings:
            return .get
        case .readNews:
            return .get
        case .readSyllabusDetails:
            return .get
        case .readSyllabusWith:
            return .get
        case .createSchedule:
            return .post
        case .updateSchedule:
            return .put
        case .readSchedule:
            return .get
        case .deleteSchedule:
            return .delete
        }
    }
    
    var path: String {
        switch self {
            
        case .createUser:
            return "/users/"
        case .readUser(let id):
            return "/users/\(id.description)/"
        case .updateUser(let id, _):
            return "/users/\(id.description)/"
        case .readNewsHeadings:
            return "/news-headings/"
        case .readNews(let id):
            return "/news/code-\(id.description)/"
        case .readSyllabusDetails(let id):
            return "/syllabuses/\(id.description)/"
        case .readSyllabusWith(let dayID, let periodID):
            return "/syllabuses/day-\(dayID.description)/period-\(periodID.description)/"
        case .createSchedule:
            return "/user-schedules/"
        case .readSchedule(let id, let quarter):
            return "/user-schedules/user-\(id.description)/quarter-\(quarter.description)/"
        case .updateSchedule(let id, _):
            return "/user-schedules/\(id.description)/"
        case .deleteSchedule(let id):
            return "/user-schedules/\(id.description)/"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createUser(let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

        case .updateUser(_, let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

        case .createSchedule(let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        
        case .updateSchedule(_, let params):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)

        default:
            break
        }
        return urlRequest
    }
    
}
