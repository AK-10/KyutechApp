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
        courseCollection.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: "deleteCell")
    }
    
    func setupDateLabel() {
        guard let day = selectedDay, let period = selectedPeriod else { return }
        dateLabel.text = "\(day.ja()) \(period+1)限"
        
    }
    
    func getSyllabuses() {
        guard let day = selectedDay, let period = selectedPeriod, let quarter = selectedQuarter else { print("day & period is nil"); return }
        let activityIndicator = MDCActivityIndicator()
        courseCollection.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: courseCollection.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: courseCollection.centerYAnchor).isActive = true
        activityIndicator.cycleColors = [.red, .blue, .green]
        activityIndicator.startAnimating()
        SyllabusModel.readSyllabusWith(day: day.rawValue, period: period, onSuccess: { [weak self] (retSyllabuses) in
            self?.syllabuses = retSyllabuses.filter{ $0.getQuarterCodes().contains(quarter) }
            DispatchQueue.main.async {
                self?.courseCollection.reloadData()
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            }, onError: { () in
                print("Error: error")
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}

