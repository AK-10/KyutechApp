//
//  EditCourseViewController+CollectionView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

extension EditCourseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selectedSchedule != nil) ? syllabuses.count + 1 : syllabuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if selectedSchedule != nil && indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deleteCell", for: indexPath)
            let label = UILabel()
            label.backgroundColor = .red
            label.textColor = .white
            label.textAlignment = .center
            label.text = "授業を削除"
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            cell.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            return cell
        } else {
            let row = (selectedSchedule != nil) ? indexPath.item - 1: indexPath.item
            let syllabus = syllabuses[row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCell", for: indexPath) as! RoundHeadCollectionCell
            guard let depart = UserDefaults.standard.int(forKey: .department) else { return cell }
            let participant: Syllabus.TargetParticipantsInfo? = syllabus.targetParticipantsInfos.filter{ $0.targetParticipants.contains(Department(rawValue: depart-200)!.ja()) }.first
            cell.setSubLabelNumberOfLine(3)
            let color = participant?.getColorByCreditKind() ?? .gray
            let roundText = participant?.getKind() ?? "他"
            cell.setup(roundLabelText: roundText, color: color, title: syllabus.title, date: syllabus.teacherName)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = (selectedSchedule != nil && indexPath.item == 0) ? CGFloat(32) : CGFloat(64)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSchedule != nil && indexPath.item == 0 {
            let alert = MDCAlertController(title: "注意", message: "削除したデータは復元できません")
            let deleteAction = MDCAlertAction(title: "削除", handler: {_ in
                UserScheduleModel.deleteSchedule(scheduleId: (self.selectedSchedule?.id)!, onSuccess: { [weak self] () in
                    self?.dismiss(animated: true, completion: {
                        let message = MDCSnackbarMessage(text: "削除しました")
                        message.duration = 2
                        MDCSnackbarManager.setPresentationHostView(self?.view)
                        MDCSnackbarManager.show(message)
                    })
                    let tabBarVC = self?.presentingViewController as! UITabBarController
                    let viewController = tabBarVC.viewControllers?.filter{ $0 is ScheduleViewController }.first
                    guard let scheduleVC = viewController as? ScheduleViewController else { return }
                    scheduleVC.getUserSchedule()
                    }, onError: { [weak self] () in
                        self?.dismiss(animated: true, completion: nil)
                })
            })
            deleteAction.accessibilityAttributedLabel = NSAttributedString(string: "注意", attributes: [.foregroundColor:UIColor.red])
            let cancelAction = MDCAlertAction(title: "キャンセル", handler: {_ in})
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            let row = (selectedSchedule != nil) ? indexPath.item - 1 : indexPath.item
            let syllabusId = syllabuses[row].id
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
}

