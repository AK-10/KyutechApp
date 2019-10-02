//
//  NewsHeadingModel.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import Alamofire

class NewsHeadingModel {
    
    class func readNewsHeadings(onSuccess: @escaping ([NewsHeading]) -> Void, onError: @escaping () -> Void)  {
        Alamofire.request(Router.readNewsHeadings).responseJSON(completionHandler: { res in
            print("\(String(describing: res.request?.url))")
            if (res.error != nil) {
                onError()
                print("error: \(res.error!)")
            } else {
                let status: Int = res.response?.statusCode ?? -1
                if status >= 200 && status < 300 {
                    guard let data = res.value else { print("data is nil"); return }
                    let dataDict = data as! [String:Any]
                    let items = dataDict["results"] as! [Parameters]
                    
                    let newsHeadings: [NewsHeading] = items.map { (newsHeading) -> NewsHeading in
                        let item = try! JSONSerialization.data(withJSONObject: newsHeading, options: [])
                        return try! JSONDecoder().decode(NewsHeading.self, from: item)
                    }
                    onSuccess(newsHeadings)
                } else {
                    print("error: status is invalid")
                    onError()
                }
            }
            
        })
    }
}
