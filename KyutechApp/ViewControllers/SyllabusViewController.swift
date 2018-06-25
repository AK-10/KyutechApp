//
//  SyllabusViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/15.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class SyllabusViewController: UIViewController {
    
    @IBOutlet weak var syllabusTable: UITableView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var memoView: PlaceHolderedTextView!
    @IBOutlet weak var attendIconImageView: UIImageView!
    @IBOutlet weak var memoIconImageView: UIImageView!
    @IBOutlet weak var lateLabel: UILabel!
    @IBOutlet weak var absentLabel: UILabel!
    
    @IBOutlet weak var lateMinusButton: UIButton!
    @IBOutlet weak var latePlusButton: UIButton!
    @IBOutlet weak var absentMinusButton: UIButton!
    @IBOutlet weak var absentPlusButton: UIButton!
    
    var recievedSchedule: UserSchedule? = nil
    
    deinit {
        print("deinited \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        setupButtons()
        setupLabels()
        setupImageViews()
        setupNavigationBar()
        setupMemoView()
        setupTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        resignFirstResponder()
    }
    
    func setupButtons() {
        lateMinusButton.addTarget(self, action: #selector(editNumLabel(_:)), for: .touchUpInside)
        latePlusButton.addTarget(self, action: #selector(editNumLabel(_:)), for: .touchUpInside)
        absentMinusButton.addTarget(self, action: #selector(editNumLabel(_:)), for: .touchUpInside)
        absentPlusButton.addTarget(self, action: #selector(editNumLabel(_:)), for: .touchUpInside)
    }
    func setupLabels() {
        guard let schedule = recievedSchedule else { return }
        
        self.absentLabel.text = schedule.absentNum?.description
        self.lateLabel.text = schedule.lateNum?.description
        
    }
    
    @objc func editNumLabel(_ sender: UIButton) {
        let numOfLate = Int(lateLabel.text!)!
        let numOfAbsent = Int(absentLabel.text!)!
        if sender == lateMinusButton && numOfLate > 0 {
            lateLabel.text = (numOfLate - 1).description
        } else if sender == latePlusButton && numOfLate < 15 {
            lateLabel.text = (numOfLate + 1).description
        } else if sender == absentMinusButton && numOfAbsent > 0 {
            absentLabel.text = (numOfAbsent - 1).description
        } else if sender == absentPlusButton && numOfAbsent < 15 {
            absentLabel.text = (numOfAbsent + 1).description
        }
    }
    
    func setupImageViews() {
        attendIconImageView.tintColor = .lightGray
        memoIconImageView.tintColor = .lightGray
    }
    
    func setupTable() {
        syllabusTable.delegate = self
        syllabusTable.dataSource = self
        let nib = UINib(nibName: "SimpleTableCell", bundle: nil)
        syllabusTable.register(nib, forCellReuseIdentifier: "Syllabus")
        syllabusTable.estimatedRowHeight = 64
        syllabusTable.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupNavigationBar() {
        guard let navigationItem = navbar.topItem else { return }
        guard let courseTitle = recievedSchedule?.syllabus.title else { return }
        let titleLabel = UILabel()
        titleLabel.text = courseTitle
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let rightBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "saveIcon"), style: .done, target: self, action: #selector(saveUserSchedule(_:)))
        
//    backButton
        let leftButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrowIos") , style: .done, target: self, action: #selector(tappedLeftButton(_:)))

        rightBarButton.tintColor = .gray
        navigationItem.rightBarButtonItem = rightBarButton
        leftButtonItem.tintColor = .gray
        navigationItem.leftBarButtonItem = leftButtonItem
        
        navbar.removeBottomBorder()
        navbar.addShadow()
    }
    
    @objc func saveUserSchedule(_ sender: Any) {
        updateSchedule()
    }

    func updateSchedule() {
        guard let userSchedule = recievedSchedule else { return }
        guard let late = lateLabel.text, let absent = absentLabel.text, let memo = memoView.text else { return }
        
        let activityIndicator = MDCActivityIndicator()
        syllabusTable.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.cycleColors = [.blue, .red, .yellow, .green]
        activityIndicator.centerXAnchor.constraint(equalTo: syllabusTable.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: syllabusTable.centerYAnchor).isActive = true
        syllabusTable.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
        
        UserScheduleModel.updateUserSchedule(scheduleId: userSchedule.id, syllabusId: userSchedule.syllabus.id, day: userSchedule.day, period: userSchedule.period, quarter: userSchedule.quarter, late: Int(late)!, absent: Int(absent)!, memo: memo, onSuccess: { [weak self] (schedule) in
            self?.recievedSchedule = schedule
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            self?.memoView.text = self?.recievedSchedule?.memo
            self?.absentLabel.text = self?.recievedSchedule?.absentNum?.description
            self?.lateLabel.text = self?.recievedSchedule?.lateNum?.description
            let snackMessage = MDCSnackbarMessage()
            snackMessage.duration = 2
            snackMessage.text = "更新しました"
            MDCSnackbarManager.setPresentationHostView(self?.view)
            MDCSnackbarManager.show(snackMessage)
            }, onError: { [weak self] () in
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self?.memoView.text = self?.recievedSchedule?.memo
                self?.absentLabel.text = self?.recievedSchedule?.absentNum?.description
                self?.lateLabel.text = self?.recievedSchedule?.lateNum?.description
                let snackMessage = MDCSnackbarMessage()
                snackMessage.duration = 2
                snackMessage.text = "更新に失敗しました"
                MDCSnackbarManager.setPresentationHostView(self?.view)
                MDCSnackbarManager.show(snackMessage)
        })
    }
    
    func setupMemoView() {
        memoView.delegate = self
        memoView.tintColor = UIColor.extendedInit(from: "#00BCD9")!
        
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardToolBar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(tappedDone(_:)))
        keyboardToolBar.items = [spacer, doneButton]
        memoView.inputAccessoryView = keyboardToolBar
        
        guard let memoText = recievedSchedule?.memo else { return }
        memoView.text = memoText
    }
    
    @objc func tappedDone(_ sender: Any) {
        if memoView.isFirstResponder {
            memoView.resignFirstResponder()
        }
    }

    @objc func tappedLeftButton(_ sender: Any) {
        UIApplication.shared.statusBarStyle = .lightContent
        dismiss(animated: true, completion: nil)
    }

}

extension SyllabusViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
}

extension SyllabusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Syllabus.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sections = Syllabus.keys
        let header = UILabel()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 16
        paragraphStyle.headIndent = 16
        let attributedString = NSAttributedString(string: sections[section], attributes: [.paragraphStyle: paragraphStyle])
        header.attributedText = attributedString
        
        header.backgroundColor = UIColor.extendedInit(from: "#f1f1f1")!
        header.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        header.textColor = .darkGray
        header.textAlignment = .left
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let syllabus = recievedSchedule?.syllabus else { return 0 }
        return syllabus.values(key: Syllabus.keys[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Syllabus") as! SimpleTableCell
        guard let syllabus = recievedSchedule?.syllabus else { return cell }
        cell.setup(content: syllabus.values(key: Syllabus.keys[indexPath.section])[indexPath.item], url: "")
        return cell
    }
    
}
