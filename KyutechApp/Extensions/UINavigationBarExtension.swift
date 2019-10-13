//
//  UINavigationBarExtension.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func removeBottomBorder() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
//        if #available(iOS 13.0, *) {
//            UINavigationBarAppearance().shadowColor = UIColor.clear
//        } else {
//            // Fallback on earlier versions
//            self.setBackgroundImage(UIImage(), for: .default)
//            self.shadowImage = UIImage()
//        }

    }
    
    func addShadowToBar(color: UIColor) {
        self.addShadow()
//        let shadowView = UIView()
//        self.insertSubview(shadowView, at: 1)
//        shadowView.translatesAutoresizingMaskIntoConstraints = false
//        shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: -56).isActive = true
//        shadowView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        shadowView.addShadow()
//        shadowView.backgroundColor = color
//        self.sendSubviewToBack(shadowView)
    }
}
