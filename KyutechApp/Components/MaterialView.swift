//
//  MaterialView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/25.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class MaterialView: UIView {
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }

    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }

    func setElevation() {
        self.shadowLayer.elevation = .cardPickedUp
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
