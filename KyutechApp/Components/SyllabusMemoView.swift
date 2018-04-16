//
//  SyllabusMemoView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

@IBDesignable
class SyllabusMemoView: UIView {

    @IBOutlet weak var memoTextView: MaterialTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = Bundle.main.loadNibNamed("SyllabusMemoView", owner: self, options: nil)?.first as! UIView
        let width = self.frame.width
        let height = self.frame.height
        view.frame.size = CGSize(width: width, height: height)
        addSubview(view)
    }

}
