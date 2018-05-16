//
//  SettingCardCellCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/02.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class SimpleCardCell: MDCCardCollectionCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(title: String?, date: String?) {
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        titleLabel.lineBreakMode = .byTruncatingMiddle
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.6
        
        titleLabel.text = title ?? "Error"
        layer.cornerRadius = 0
        dateLabel.text = date ?? ""
    }
    
}
