//
//  SettingCardCellCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/02.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class SettingCardCell: MDCCardCollectionCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(title: String?) {
        titleLabel.text = title ?? "Error"
        layer.cornerRadius = 0
    }
    
}
