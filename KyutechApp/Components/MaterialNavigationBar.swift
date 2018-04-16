//
//  MaterialNavigationBar.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class MaterialNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        addShadow()
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addShadow()
    }

    

}
