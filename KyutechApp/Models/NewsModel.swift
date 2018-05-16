//
//  NewsModel.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

class NewsModel {
    
    var nextURL: String? = ""
    
    class func readNews(newsID: Int, onSuccess: @escaping ([News]) -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.readNews(id: newsID)).responseJSON(completionHandler: { res in
            if res.error != nil {
                onError()
                print("error: response is nil")
            } else {
                let status: Int = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value else { print("data is nil"); return }
                    var newsArray: [News] = []
                    let dataDict = resData as! Parameters
                    let newsJSON = dataDict["results"] as! [Parameters]
                    for item in newsJSON {
                        let infos = item["infos"] as! [[String:String]]
                        let attachmentInfos = item["attachment_infos"] as? [[String:String]]
                        newsArray.append(News(infos: infos, attachmentInfos: attachmentInfos))
                    }
                    onSuccess(newsArray)
                } else {
                    print("data is nil")
                    onError()
                }
            }
        })
    }
}
