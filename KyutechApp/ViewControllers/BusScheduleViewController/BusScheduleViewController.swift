//
//  BusScheduleViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/13.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class BusScheduleViewController: UIViewController {
    
    var scrollview: UIScrollView = UIScrollView()

    @IBOutlet weak var navbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollview)
        self.view.sendSubview(toBack: scrollview)
        let pictureWidth = UIScreen.main.bounds.width
        let pictureHeight = pictureWidth * 1.5
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.topAnchor.constraint(equalTo: navbar.bottomAnchor).isActive = true
        scrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollview.contentSize = CGSize(width: pictureWidth, height: pictureHeight * 2)
        let timeScheduleImage = UIImageView()
        let busCalenderImage = UIImageView()
        timeScheduleImage.image = #imageLiteral(resourceName: "busTimeSchedule")
        busCalenderImage.image = #imageLiteral(resourceName: "busCalender")
        timeScheduleImage.contentMode = .scaleAspectFit
        busCalenderImage.contentMode = .scaleAspectFit
        timeScheduleImage.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: pictureWidth, height: pictureHeight))
        busCalenderImage.frame = CGRect(origin: CGPoint(x: 0, y: pictureHeight), size: CGSize(width: pictureWidth, height: pictureHeight))
        scrollview.addSubview(timeScheduleImage)
        scrollview.addSubview(busCalenderImage)
    }
    
    func setupNavigationBar() {
        navbar.removeBottomBorder()
        navbar.addShadow()
    }
}
