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
    
    let indicator = ActivityIndicatorWithBackground()
    
    var selectedDay: Week? = nil
    var selectedPeriod: Int? = nil
    var selectedQuarter: Int? = nil
    var selectedSchedule: UserSchedule? = nil
    var syllabuses: [Syllabus] = []
    
    deinit {
        print("\(self) deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSyllabuses()
        setupCollection()
        setupDateLabel()
        setupIndicator()
        
        // Do any additional setup after loading the view.
    }
    
    func setupIndicator() {
        self.view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(indicator)
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
        courseCollection.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: "deleteCell")
    }
    
    func setupDateLabel() {
        guard let day = selectedDay, let period = selectedPeriod else { return }
        dateLabel.text = "\(day.ja()) \(period+1)限"
    }
    
    func getSyllabuses() {
        guard let day = selectedDay, let period = selectedPeriod, let quarter = selectedQuarter else { print("day & period, quarter is nil"); return }
        indicator.startAnimating()
        print(day.rawValue)
        SyllabusModel.readSyllabusWith(day: day.ja(), period: period, onSuccess: { [weak self] (retSyllabuses) in
            self?.syllabuses = retSyllabuses.filter{ $0.getQuarterCodes().contains(quarter) }
            DispatchQueue.main.async {
                self?.courseCollection.reloadData()
            }
            self?.indicator.stopAnimating()
            }, onError: { [weak self] () in
                print("Error: error")
                self?.indicator.stopAnimating()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}

