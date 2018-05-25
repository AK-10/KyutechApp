//
//  ScheduleViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var scheduleCollection: UICollectionView!
    weak var quarterSelectController: PullDownMenuViewController!
    @IBOutlet weak var pullDownMenuControllConstraint: NSLayoutConstraint!
    @IBOutlet weak var navbar: MaterialNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupNavigationBar()
        setupPullDownMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scheduleCollection.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navbar.removeShadow()
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
    
    func setupPullDownMenu() {
        if childViewControllers.count == 1 {
            if let pulldownMenu = childViewControllers[0] as? PullDownMenuViewController {
                quarterSelectController = pulldownMenu
                quarterSelectController.delegate = self
            }
        }
    }
    
    func setupNavigationBar() {
        let navigationItem = UINavigationItem()
        let titleLabel = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animatePullDownMenu(tapped:)))
        titleLabel.text = "1st Quarter ▼"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.sizeToFit()
        titleLabel.textColor = .white
        titleLabel.addGestureRecognizer(tapGesture)
        titleLabel.isUserInteractionEnabled = true
        
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(tappedRightBarButton(_:)))
        navigationItem.rightBarButtonItem = editButton
        navigationItem.titleView = titleLabel

        navbar.setItems([navigationItem], animated: true)
    }
    
    @objc func tappedRightBarButton(_ sender: Any) {
        guard let rightBarButton = navbar.topItem?.rightBarButtonItem else { return }
        if isEditting() {
            rightBarButton.title = "Edit"
        } else {
            rightBarButton.title = "Done"
        }
    }

    @objc func animatePullDownMenu(tapped by: Any) {
        let titleLabel = navbar.topItem?.titleView as! UILabel
        titleLabel.text?.removeLast()
        if pullDownMenuControllConstraint.constant == 0 {
            if let button = by as? UIButton {
                titleLabel.text = (button.titleLabel?.text)! + " ▼"
            } else {
                titleLabel.text = titleLabel.text! + "▼"
            }
            pullDownMenuControllConstraint.constant = -160
        } else {
            pullDownMenuControllConstraint.constant = 0
            titleLabel.text = titleLabel.text! + "▲"
        }
        
        titleLabel.sizeToFit()
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }

    func isEditting() -> Bool {
        guard let rightBarButton = navbar.topItem?.rightBarButtonItem else { return false }
        guard let buttonTitle = rightBarButton.title else { return false }
        if buttonTitle == "Edit" {
            return false
        } else {
            return true
        }
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private func dayAndPeriod(index: Int) -> (String, Int) {
        let day = index % 5
        let period = Int(index/5)
        return (Week.toRawFrom(hash: day), period)
    }
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditting() {
            
            let storyboard = UIStoryboard(name: "ScheduleOption", bundle: nil)
            let editCourseVC = storyboard.instantiateInitialViewController() as! EditCourseViewController
            editCourseVC.modalTransitionStyle = .crossDissolve
            let pair = dayAndPeriod(index: indexPath.row)
            editCourseVC.selectedDay = pair.0
            editCourseVC.selectedPeriod = pair.1
            present(editCourseVC, animated: true, completion: nil)
            
        } else {
            // カードに授業があれば詳細画面へ遷移
            let cell = collectionView.cellForItem(at: indexPath) as! CourseCardCell
            if cell.classNameLabel.text != "" {
                let storyboard = self.storyboard!
                let syllabusVC = storyboard.instantiateViewController(withIdentifier: "Syllabus")
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

extension ScheduleViewController: PullDownMenuViewDelegate {
    func setupButtons(_ pullDownMenuView: PullDownMenuViewController) {
        pullDownMenuView.fistButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.secondButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.thirdButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.fourthButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
    }
}
