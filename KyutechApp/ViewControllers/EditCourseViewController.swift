//
//  EditCourseViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/14.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class EditCourseViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var courseCollection: UICollectionView!
    
    var selectedDay: String? = nil
    var selectedPeriod: Int? = nil
    
    var syllabuses: [Syllabus] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupCollection()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        courseCollection.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func setupCollection() {
        courseCollection.delegate = self
        courseCollection.dataSource = self
        
        let nib = UINib(nibName: "RoundHeadCollectionCell", bundle: nil)
        courseCollection.register(nib, forCellWithReuseIdentifier: "CourseCell")
    }
    
    func setupDataSource() {
        guard let day = selectedDay, let period = selectedPeriod else { print("day & period is nil"); return }
        let xPoint = courseCollection.frame.width / 2.0
        let yPoint = courseCollection.frame.height / 2.0
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.center = CGPoint(x: xPoint, y: yPoint)
        activityIndicator.sizeToFit()
        activityIndicator.cycleColors = [.red, .blue, .green]
        courseCollection.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        SyllabusModel.readSyllabusWith(day: day, period: period, onSuccess: { [weak self] (retSyllabuses) in
            self?.syllabuses = retSyllabuses
            self?.courseCollection.reloadData()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            }, onError: { () in
                print("Error: error")
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }


}

extension EditCourseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return syllabuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let syllabus = syllabuses[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCell", for: indexPath) as! RoundHeadCollectionCell
        cell.setup(roundLabelText: String(syllabus.title.first!) , color: .red, title: syllabus.title, date: syllabus.teacherName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = CGFloat(64)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
