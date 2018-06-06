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
    @IBOutlet weak var memoView: UITextView!
    
    var recievedSchedule: UserSchedule? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func setupTable() {
        syllabusTable.delegate = self
        syllabusTable.dataSource = self
        let nib = UINib(nibName: "SimpleTableCell", bundle: nil)
        syllabusTable.register(nib, forCellReuseIdentifier: "Syllabus")
        
//        syllabusTable.tableHeaderView = memoView
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
    
    }

    func setupMemoView() {
        memoView.delegate = self
        
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardToolBar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(tappedDone(_:)))
        keyboardToolBar.items = [spacer, doneButton]
        memoView.inputAccessoryView = keyboardToolBar
        
        memoView.layer.borderColor = borderColor.cgColor
        memoView.layer.cornerRadius = 5.0
        memoView.layer.borderWidth = 1.0
        
        guard let memoText = recievedSchedule?.memo else { return }
        memoView.text = memoText
    }
    
    @objc func tappedDone(_ sender: Any) {
        if memoView.isFirstResponder {
            memoView.resignFirstResponder()
        }
    }

    @objc func tappedLeftButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension SyllabusViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.layer.borderColor = UIColor.extendedInit(from: "00BCD4")?.cgColor

        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor

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
        paragraphStyle.firstLineHeadIndent = 12
        paragraphStyle.headIndent = 12
        let attributedString = NSAttributedString(string: sections[section], attributes: [.paragraphStyle: paragraphStyle])
        header.attributedText = attributedString
        
        
        header.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        header.font = UIFont.systemFont(ofSize: 16)
        header.textColor = .white
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
