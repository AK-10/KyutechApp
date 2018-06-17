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
    
    func addBorder(side: Side, weight: CGFloat, color: UIColor) {
        DispatchQueue.main.async {
            switch side {
            case .top:
                let border = CALayer()
                border.backgroundColor = color.cgColor
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: weight)
                self.layer.addSublayer(border)
            case .left:
                let border = CALayer()
                border.backgroundColor = color.cgColor
                border.frame = CGRect(x: 0, y: 0, width: weight, height: self.frame.height)
                self.layer.addSublayer(border)
            case .right:
                let border = CALayer()
                border.backgroundColor = color.cgColor
                border.frame = CGRect(x: self.frame.width - weight, y: 0, width: weight, height: self.frame.height)
                self.layer.addSublayer(border)
            case .bottom:
                let border = CALayer()
                border.backgroundColor = color.cgColor
                border.frame = CGRect(x: 0, y: self.frame.height - weight, width: self.frame.width, height: weight)
                self.layer.addSublayer(border)
            }
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
