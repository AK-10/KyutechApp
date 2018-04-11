//
//  NewsCollectionCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class NewsCollectionCell: MDCCardCollectionCell {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var newsTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup() {
        self.cornerRadius = 0
        self.clipsToBounds = true
        
        roundLabel.layer.cornerRadius = roundLabel.bounds.height / 2.1
        roundLabel.clipsToBounds = true
    }
    
}
