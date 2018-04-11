//
//  MaterialNavigationBar.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class MaterialNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setup()
    }
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup() {
        let barLayer = self.layer as! MDCShadowLayer
        barLayer.elevation = .appBar
        barLayer.masksToBounds = false
        isTranslucent = false
    }

}
