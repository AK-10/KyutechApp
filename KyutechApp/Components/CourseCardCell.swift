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
    
//    override class var layerClass: AnyClass {
//        return MDCShadowLayer.self
        // エラーを吐く 理由は謎
        // Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[MDCShadowLayer setShapedBackgroundColor:]: unrecognized selector sent to instance 0x60400028a0a0'
//    }

    
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
        roomNumberLabel.minimumScaleFactor = 0.6
        
//        DispatchQueue.main.async {
//            self.roomNumberLabel.layer.cornerRadius = self.roomNumberLabel.bounds.height / 4
//            self.roomNumberLabel.clipsToBounds = true
//        }

        classNameLabel.text = course
        roomNumberLabel.text = room
//        if let num = roomNum {
//            roomNumberLabel.text = num.description
//        } else {
//            roomNumberLabel.text = ""
//        }
        backgroundColor = color
    }
}
