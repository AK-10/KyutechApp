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
    
    static var nextURL: String? = nil
    
    class func readNews(newsID: Int, onSuccess: @escaping ([News]) -> Void, onError: @escaping () -> Void) {
        Alamofire.request(Router.readNews(id: newsID)).responseJSON(completionHandler: { res in
            if res.error != nil {
                onError()
                print("error: response is nil")
            } else {
                let status: Int = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let resData = res.value else { print("data is nil"); return }
                    let dataDict = resData as! Parameters
                    nextURL = dataDict["next"] as? String
                    let results = dataDict["results"] as! [Parameters]
                    let newsArray: [News] = results.map {
                        (item) in
                        let itemData = try! JSONSerialization.data(withJSONObject: item, options: [])
                        return try! JSONDecoder().decode(News.self, from: itemData)
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
