//
//  ActivityIndicatorWithBackground.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/10/31.
//  Copyright © 2018 小西篤志. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MDCActivityIndicator
import MaterialComponents.MDCShadowLayer


class ActivityIndicatorWithBackground: UIView {
    
    var indicator = MDCActivityIndicator()
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.indicator.cycleColors = [UIColor.extendedInit(from: "5190f9")!, UIColor.extendedInit(from: "f15142")!, UIColor.extendedInit(from: "ffc416")!, UIColor.extendedInit(from: "44b361")!]
        addSubview(indicator)
        self.bringSubviewToFront(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        self.layer.cornerRadius = 20
//        self.clipsToBounds = true
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 40).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func startAnimating() {
        self.isHidden = false
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        self.isHidden = true
        indicator.stopAnimating()
    }
    
    
}
