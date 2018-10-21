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
    var titleView: TitleLabelWithTriangle!
    var schedules: [UserSchedule] = []
    
    var quarter: Int? = UserDefaults.standard.int(forKey: .quarter)
    
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
        if children.count == 1 {
            if let pulldownMenu = children[0] as? PullDownMenuViewController {
                quarterSelectController = pulldownMenu
                quarterSelectController.delegate = self
            }
        }
    }
    
    func setupNavigationBar() {
        navbar.delegate = self
        let navigationItem = UINavigationItem()
        let q = ((quarter ?? 0) + 1).description
        titleView = TitleLabelWithTriangle(title: "第\(q)クォーター")
        self.titleView.delegate = self
//        titleView.titleLabel.
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "editIcon"), style: .plain, target: self, action: #selector(tappedRightBarButton(_:)))
        editButton.tintColor = .white
        editButton.title = "edit"
        navigationItem.rightBarButtonItem = editButton
        navigationItem.titleView = titleView
        navigationItem.titleView?.sizeToFit()

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
            self.navbar.barTintColor = UIColor.extendedInit(from: "#00BCD9")!
            self.quarterSelectController.view.backgroundColor = UIColor.extendedInit(from: "#00BCD9")!
        } else {
            // done to edit
            rightBarButton.title = "done"
            rightBarButton.image = #imageLiteral(resourceName: "doneIcon")
            // changeNavigationColor
            self.navbar.barTintColor = .orange
            self.quarterSelectController.view.backgroundColor = .orange
        }
    }

    @objc func animatePullDownMenu(tapped by: Any) {
        titleView.rotateTriangle()
        if pullDownMenuControllConstraint.constant == 0 {
            if let button = by as? UIButton {
                titleView.titleLabel.text = (button.titleLabel?.text)!
//                前回開いた時と同じquaterにするための処理(保存)
                UserDefaults.standard.set(button.tag, forKey: .quarter)
                quarter = button.tag
                getUserSchedule()
            }
            pullDownMenuControllConstraint.constant = -160
        } else {
            pullDownMenuControllConstraint.constant = 0
        }
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
        guard let userId = UserDefaults.standard.int(forKey: .primaryKey) else { return }
        let activityIndicator = MDCActivityIndicator()
        scheduleCollection.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.cycleColors = [.blue, .red, .yellow, .green]
        activityIndicator.centerXAnchor.constraint(equalTo: scheduleCollection.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: scheduleCollection.centerYAnchor).isActive = true
        scheduleCollection.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        UserScheduleModel.getSchedule(userId: userId, quarter: quarter ?? 0, onSuccess: { [weak self] (resSchedules) in
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

extension ScheduleViewController: PullDownMenuViewDelegate, TitleLabelWithtriangleDelegate {
    func setupButtons(_ pullDownMenuView: PullDownMenuViewController) {
        pullDownMenuView.firstButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.secondButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.thirdButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
        pullDownMenuView.fourthButton.addTarget(self, action: #selector(animatePullDownMenu(tapped:)), for: .touchUpInside)
    }
    
    func setTapLabelAction(_ label: TitleLabelWithTriangle) {
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animatePullDownMenu(tapped:)))
        label.addGestureRecognizer(tapGesture)
    }
}

extension ScheduleViewController:  UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
