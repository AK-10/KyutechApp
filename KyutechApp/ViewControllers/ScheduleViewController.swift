//
//  ScheduleViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleCollection: UICollectionView!

    @IBOutlet weak var navbar: MaterialNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scheduleCollection.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupCollection() {
        
        scheduleCollection.delegate = self
        scheduleCollection.dataSource = self
        
        let nib = UINib(nibName: "CourseCardCell", bundle: nil)
        scheduleCollection.register(nib, forCellWithReuseIdentifier: "CourseCard")
    }

}


extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCard", for: indexPath) as! CourseCardCell
        if indexPath.row % 4 == 0 {
            cell.setup(course: "automata", roomNum: 1213)
            cell.backgroundColor = UIColor.orange
        } else {
            cell.setup(course: "", roomNum: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionHeight = collectionView.bounds.height
        let collectionWidth = collectionView.bounds.width
        let allowHeight = collectionHeight - 44
        let allowWidth = collectionWidth - 44
        return CGSize(width: allowWidth / 5, height: allowHeight / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}
