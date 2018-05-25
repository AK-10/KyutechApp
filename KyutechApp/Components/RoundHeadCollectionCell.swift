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
    
    func setup(roundLabelText: String, color: UIColor, title: String, date: String) {
        newsTypeLabel.adjustsFontSizeToFitWidth = true
        newsTypeLabel.minimumScaleFactor = 0.8
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.6
        
        self.roundLabel.text = roundLabelText
        self.roundLabel.backgroundColor = color
        self.newsTypeLabel.text = title
        self.dateLabel.text = date
        self.cornerRadius = 0
        self.clipsToBounds = true
        
        DispatchQueue.main.async {
            self.roundLabel.layer.cornerRadius = self.roundLabel.bounds.height / 2
        }
  
        roundLabel.clipsToBounds = true
    }
    
    func courseMode() {
        dateLabel.frame.size = CGSize(width: 0, height: 0)
        
        newsTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 32).isActive = true
    }
    
}
