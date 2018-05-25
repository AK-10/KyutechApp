//
//  News.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

struct News: Decodable {
    let id: Int
    let newsHeadingCode: Int
    let sourceURL: String
    
    struct Info: Decodable {
        let title: String
        let content: String
    }
    let infos: [Info]
    
    struct AttachmentInfo: Decodable {
        let title: String
        let linkName: String
        let url: String
        
        private enum CodingKeys: String, CodingKey {
            case title
            case linkName = "link_name"
            case url
        }
    }
    
    let attachmentInfos: [AttachmentInfo]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case newsHeadingCode = "news_heading_code"
        case sourceURL = "source_url"
        case infos
        case attachmentInfos = "attachment_infos"
    }
    
    func getTexts() -> (String, String) {
        var firstText: String = ""
        var secondText: String = ""
        switch newsHeadingCode {
        case 357, 364, 379, 372:
            infos.forEach{ info in
                if info.title == "タイトル" {
                    firstText = info.content
                } else if info.title == "日付" {
                    secondText = info.content
                } else { }
            }
        case 391:
            infos.forEach{ info in
                if info.title == "科目名" {
                    firstText = info.content
                } else if info.title == "時限" {
                    firstText += " " + info.content
                }  else if info.title == "日付" {
                    secondText = info.content
                } else {}
            }
        case 361:
            infos.forEach{ info in
                if info.title == "休講科目" {
                    firstText = info.content
                } else if info.title == "時限" {
                    firstText += " " + info.content
                }  else if info.title == "日付" {
                    secondText = info.content
                } else {}
            }
        case 363:
            infos.forEach{ info in
                if info.title == "補講科目" {
                    firstText = info.content
                } else if info.title == "時限" {
                    firstText += " " + info.content
                }  else if info.title == "日付" {
                    secondText = info.content
                } else {}
            }
        case 393:
            infos.forEach{ info in
                if info.title == "対象学科等" {
                    firstText = info.content
                } else { }
            }
        case 373, 368, 370:
            infos.forEach{ info in
                if info.title == "件名" {
                    firstText = info.content
                } else { }
            }
        case 367:
            infos.forEach{ info in
                if info.title == "件名" {
                    firstText = info.content
                } else if info.title == "期日" {
                    secondText = info.content
                } else { }
            }
        default:
            return ("error", "error")
        }
        
        return (firstText, secondText)
    }
    
    func getSections() -> [String] {
        return infos.map{ $0.title } + attachmentInfos.map{ $0.title } + ["ソース"]
    }
    
    func getContents() -> [String] {
        return infos.map{ $0.content } + attachmentInfos.map{ $0.linkName } + [sourceURL]
    }
    
    func getURLs() -> [String] {
        var retStrs:[String] = []
        for _ in 0 ..< infos.count {
            retStrs.append("")
        }
        attachmentInfos.forEach{ retStrs.append($0.url) }
        return retStrs + [sourceURL]
    }
    
}
