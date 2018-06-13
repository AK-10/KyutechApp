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
    
    enum Side {
        case top
        case left
        case right
        case bottom
    }
    
    func addBorder(sides: [Side], weight: CGFloat, color: UIColor) {
        if sides.contains(.top) {
            let border = CALayer()
            border.borderColor = color.cgColor
            border.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: weight)
            layer.addSublayer(border)
        }
        if sides.contains(.left) {
            let border = CALayer()
            border.borderColor = color.cgColor
            border.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: weight, height: self.frame.height)
            layer.addSublayer(border)
        }
        if sides.contains(.right) {
            let border = CALayer()
            border.borderColor = color.cgColor
            border.frame = CGRect(x: self.frame.maxX, y: self.frame.minY, width: weight, height: self.frame.height)
            layer.addSublayer(border)
        }
        if sides.contains(.bottom) {
            let border = CALayer()
            border.borderColor = color.cgColor
            border.frame = CGRect(x: self.frame.minX, y: self.frame.maxY, width: self.frame.width, height: weight)
            layer.addSublayer(border)
        }
        
    }
    
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
