//
//  ScheduleViewController+CollectionView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private func dayAndPeriod(index: Int) -> (Week, Int) {
        let day = index % 5
        let period = Int(index/5)
        return (Week.from(index: day), period)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCard", for: indexPath) as! CourseCardCell
        cell.setup(course: "", room: "", color: .white)
        for schedule in schedules {
            if schedule.indexFrom() == indexPath.item && quarter == schedule.quarter {
                guard let depart = UserDefaults.standard.int(forKey: .department) else { return cell }
                let color: UIColor = schedule.syllabus.targetParticipantsInfos.filter{ $0.targetParticipants.contains(Department(rawValue: depart-200)!.ja()) }.first?.getColorByCreditKind() ?? .gray
                cell.setup(course: schedule.syllabus.title, room: schedule.syllabus.getPlace(), color: color)
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditting() {
            // 状態が編集中ならば授業選択画面へ
            let storyboard = UIStoryboard(name: "ScheduleOption", bundle: nil)
            let editCourseVC = storyboard.instantiateInitialViewController() as! EditCourseViewController
            editCourseVC.modalTransitionStyle = .crossDissolve
            let pair = dayAndPeriod(index: indexPath.item)
            editCourseVC.selectedDay = pair.0
            editCourseVC.selectedPeriod = pair.1
            editCourseVC.selectedQuarter = quarter
            editCourseVC.selectedSchedule = schedules.filter{ $0.day == pair.0.index() && $0.period == pair.1 }.first ?? nil
            present(editCourseVC, animated: true, completion: nil)
            
        } else {
            // カードに授業があれば詳細画面へ遷移
            let cell = collectionView.cellForItem(at: indexPath) as! CourseCardCell
            if cell.classNameLabel.text != "" {
                let storyboard = self.storyboard!
                let syllabusVC = storyboard.instantiateViewController(withIdentifier: "Syllabus") as! SyllabusViewController
                let schedule = schedules.filter{ $0.indexFrom() == indexPath.item }.first
                syllabusVC.recievedSchedule = schedule
                present(syllabusVC, animated: true, completion: nil)
            }
        }
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
