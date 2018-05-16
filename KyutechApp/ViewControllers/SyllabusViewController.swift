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
    @IBOutlet weak var navbar: MaterialNavigationBar!
    @IBOutlet weak var memoView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMemoView()
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
        let nib = UINib(nibName: "SyllabusCell", bundle: nil)
        syllabusTable.register(nib, forCellReuseIdentifier: "Syllabus")
//        syllabusTable.tableHeaderView = memoView
    }
    
    func setupNavigationBar() {
        guard let navigationItem = navbar.topItem else { return }
        let titleLabel = UILabel()
        titleLabel.text = "Automata"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel

        let leftButtonItem = UIBarButtonItem(image: UIImage(named: "cancell")! , style: .done, target: self, action: #selector(tappedLeftButton(_:)))

        leftButtonItem.tintColor = .gray
        navigationItem.leftBarButtonItem = leftButtonItem
    }

    func setupMemoView() {
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
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
}

extension SyllabusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Syllabus") as! SyllabusTableViewCell
        return cell
    }
    
}
