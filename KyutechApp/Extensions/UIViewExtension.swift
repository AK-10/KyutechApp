//
//  UIViewExtension.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
    }
    
    func removeShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
    }

}
