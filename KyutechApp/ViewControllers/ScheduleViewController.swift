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
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var dummyStatusBar: UIView!
    var schedules: [UserSchedule] = []
    
    var quarter: Int? {
        guard let barTitleLabel = navbar.topItem?.titleView as? UILabel else { return nil }
        guard let numChar = barTitleLabel.text?.first  else { return nil }
        return (Int(String(numChar)) != nil) ? Int(String(numChar))! - 1 : nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPullDownMenu()
        setupNavigationBar()
        setupCollection()
        getUserSchedule()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserSchedule()
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
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.sizeToFit()
        titleLabel.textColor = .white
        titleLabel.addGestureRecognizer(tapGesture)
        titleLabel.isUserInteractionEnabled = true
        
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "editIcon"), style: .plain, target: self, action: #selector(tappedRightBarButton(_:)))
        editButton.tintColor = .white
        editButton.title = "edit"
        navigationItem.rightBarButtonItem = editButton
        navigationItem.titleView = titleLabel

        navbar.setItems([navigationItem], animated: true)
        navbar.removeBottomBorder()
    }
    
    @objc func tappedRightBarButton(_ sender: Any) {
        guard let rightBarButton = navbar.topItem?.rightBarButtonItem else { return }
        if isEditting() {
            // edit to done
            rightBarButton.title = "edit"
            rightBarButton.image = #imageLiteral(resourceName: "editIcon")
            //change navigationColor
            self.dummyStatusBar.backgroundColor = UIColor.extendedInit(from: "#00BCD9")!
            self.navbar.barTintColor = UIColor.extendedInit(from: "#00BCD9")!
            self.quarterSelectController.view.backgroundColor = UIColor.extendedInit(from: "#00BCD9")!
        } else {
            // done to edit
            rightBarButton.title = "done"
            rightBarButton.image = #imageLiteral(resourceName: "doneIcon")
            // changeNavigationColor
            self.dummyStatusBar.backgroundColor = .orange
            self.navbar.barTintColor = .orange
            self.quarterSelectController.view.backgroundColor = .orange
        }
    }

    @objc func animatePullDownMenu(tapped by: Any) {
        let titleLabel = navbar.topItem?.titleView as! UILabel
        titleLabel.text?.removeLast()
        if pullDownMenuControllConstraint.constant == 0 {
            if let button = by as? UIButton {
                titleLabel.text = (button.titleLabel?.text)! + " ▼"
                getUserSchedule()
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
        guard let title = rightBarButton.title else { return false }
        if title == "edit" {
            return false
        } else {
            return true
        }
    }
    
    func getUserSchedule() {
        guard let quarter = quarter, let userId = UserDefaults.standard.int(forKey: .primaryKey) else { return }

        let activityIndicator = MDCActivityIndicator()
        scheduleCollection.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.cycleColors = [.blue, .red, .yellow, .green]
        activityIndicator.centerXAnchor.constraint(equalTo: scheduleCollection.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: scheduleCollection.centerYAnchor).isActive = true
        scheduleCollection.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
        UserScheduleModel.getSchedule(userId: userId, quarter: quarter, onSuccess: { [weak self] (resSchedules) in
            self?.schedules = resSchedules
            DispatchQueue.main.async {
                self?.scheduleCollection.reloadData()
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            }, onError: { () in
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        })
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private func dayAndPeriod(index: Int) -> (Week, Int) {
        let day = index % 5
        let period = Int(index/5)
        return (Week.from(hash: day), period)
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
            let pair = dayAndPeriod(index: indexPath.row)
            editCourseVC.selectedDay = pair.0
            editCourseVC.selectedPeriod = pair.1
            editCourseVC.selectedQuarter = quarter
            editCourseVC.selectedSchedule = schedules.filter{ $0.day == pair.0.hashValue && $0.period == pair.1 }.first ?? nil
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

extension ScheduleViewController: PullDownMenuViewDelegate {
    func setupButtons(_ pullDownMenuView: PullDownMenuViewController) {
        pullDownMenuView.fistButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.secondButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.thirdButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.fourthButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
    }
}
