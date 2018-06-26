//
//  ScheduleCardCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/09.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class CourseCardCell: MDCCardCollectionCell {
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        classNameLabel.text = ""
        roomNumberLabel.text = ""
        roomNumberLabel.backgroundColor = .clear
    }
    
    func setup(course: String, room: String, color: UIColor) {
        self.cornerRadius = 2
        let cellLayer = self.layer as! MDCShadowLayer
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .highlighted)
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .selected)
        cellLayer.masksToBounds = false
        
        classNameLabel.adjustsFontSizeToFitWidth = true
        classNameLabel.minimumScaleFactor = 0.8
        classNameLabel.lineBreakMode = .byTruncatingTail
        roomNumberLabel.adjustsFontSizeToFitWidth = true
        roomNumberLabel.minimumScaleFactor = 0.5
        roomNumberLabel.lineBreakMode = .byTruncatingTail
        classNameLabel.text = course
        roomNumberLabel.text = room
        
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.firstLineHeadIndent = 4
//        paragraphStyle.headIndent = 4
//        paragraphStyle.tailIndent = -4
//        paragraphStyle.alignment = .center
//        let attributedString = NSAttributedString(string: room, attributes: [.paragraphStyle: paragraphStyle])
//        roomNumberLabel.attributedText = attributedString
        if room != "" {
            let clearDarkGray = UIColor.darkGray.withAlphaComponent(0.4)
            roomNumberLabel.backgroundColor = clearDarkGray
        }
        roomNumberLabel.layer.masksToBounds = true
        roomNumberLabel.layer.cornerRadius = roomNumberLabel.frame.width / 8

//        classNameLabelTopConstraint.constant = self.bounds.height / 7
        
//        roomNumberLabelBottomConstraint.constant = self.bounds.height / 10

        backgroundColor = color
    }
    
}
