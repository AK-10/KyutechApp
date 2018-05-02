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

    
    func setup(course: String, roomNum: Int?) {
        self.cornerRadius = 2
        let cellLayer = self.layer as! MDCShadowLayer
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .highlighted)
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .selected)
        cellLayer.masksToBounds = false

        
        DispatchQueue.main.async {
            self.roomNumberLabel.layer.cornerRadius = self.roomNumberLabel.bounds.height / 3
            self.roomNumberLabel.clipsToBounds = true
        }

        classNameLabel.text = course
        if let num = roomNum {
            roomNumberLabel.text = num.description
        } else {
            roomNumberLabel.text = ""
        }
        backgroundColor = .white
    }
}
