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
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }

    
    func setup(course: String, roomNum: Int?) {
        self.cornerRadius = 2
        let cellLayer = self.layer as! MDCShadowLayer
        cellLayer.elevation = ShadowElevation(1)
        cellLayer.masksToBounds = false
        
        DispatchQueue.main.async {
            self.roomNumberLabel.layer.cornerRadius = self.roomNumberLabel.bounds.height / 2
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
