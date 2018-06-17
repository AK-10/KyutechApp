//
//  NewsCollectionCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class RoundHeadCollectionCell: MDCCardCollectionCell {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var newsTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTypeLabelLayoutConstraint: NSLayoutConstraint!
    
    
    func setup(roundLabelText: String, color: UIColor, title: String, date: String) {
        newsTypeLabel.adjustsFontSizeToFitWidth = true
        newsTypeLabel.minimumScaleFactor = 0.8
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.8
        
        self.roundLabel.text = roundLabelText
        self.roundLabel.backgroundColor = color
        self.newsTypeLabel.text = title
        self.dateLabel.text = date
        self.cornerRadius = 0
        self.clipsToBounds = true
        
        self.roundLabel.layer.cornerRadius = self.roundLabel.bounds.height / 2
  
        roundLabel.clipsToBounds = true
    }
    
    func setSubLabelNumberOfLine(_ num: Int) {
        self.dateLabel.numberOfLines = num
    }
    
}
