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
    
    var syllabuses: [Syllabus] = []
    
    deinit {
        print("\(self) deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
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
    }
    
    func setupDateLabel() {
        guard let day = selectedDay, let period = selectedPeriod else { return }
        dateLabel.text = "\(day.ja()) \(period+1)限"
        
    }
    
    func setupDataSource() {
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
        guard let depart = UserDefaults.standard.int(forKey: .department) else { return cell }
        let color: UIColor = syllabus.targetParticipantsInfos.filter{ $0.targetParticipants.contains(Department(rawValue: depart-200)!.ja()) }.first?.getColorByCreditKind() ?? .gray
        cell.setup(roundLabelText: String(syllabus.title.first!) , color: color, title: syllabus.title, date: syllabus.teacherName)
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
        let syllabusId = syllabuses[indexPath.item].id
        guard let day = selectedDay, let period = selectedPeriod, let quarter = selectedQuarter else { return }
        UserScheduleModel.createSchedule(syllabusId: syllabusId, day: day.hashValue, period: period, quarter: quarter, onSuccess: { [weak self] (newSchedule) in
            let tabBarVC = self?.presentingViewController as! UITabBarController
            let viewController = tabBarVC.viewControllers?.filter{ $0 is ScheduleViewController }.first
            guard let scheduleVC = viewController as? ScheduleViewController else { return }
            scheduleVC.getUserSchedule()

            self?.dismiss(animated: true, completion: nil)
        }, onError: { [weak self] () in
            self?.dismiss(animated: true, completion: nil)
        })
    }
}
