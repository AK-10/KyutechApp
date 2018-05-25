//
//  NSURLRequestExtension.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/25.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation

extension NSURLRequest {
    static func allowsAnyHTTPSCertificateForHost(host: String) -> Bool {
        return true
    }
}
