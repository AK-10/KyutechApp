//
//  UpdateUserInfoViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents.MDCFlatButton

class UpdateUserInfoViewController: UIViewController {

    @IBOutlet weak var BackGroundView: UIView!
    
    @IBOutlet weak var yearTextField: PickeredTextField!
    @IBOutlet weak var departmentTextField: PickeredTextField!
    
    @IBOutlet weak var updateButton: MDCFlatButton!
    @IBOutlet weak var cancelButton: MDCFlatButton!
    
    var selectedYear: Int? = UserDefaults.standard.int(forKey: .schoolYear)
    var selectedDepart: Int? = UserDefaults.standard.int(forKey: .department)
    
    let years: [SchoolYear] = Const.years

    let departments = Const.departments
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupButtons()
        setupTextFields()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor =  UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBackgroundView() {
        BackGroundView.addShadow()
    }
    
    func setupButtons() {
        updateButton.setTitle("更新", for: .normal)
        updateButton.setTitleColor(UIColor.extendedInit(from: "#00BCD9")!, for: .normal)
        updateButton.setTitleFont(UIFont.systemFont(ofSize: 16, weight: .bold), for: .normal)
        updateButton.addTarget(self, action: #selector(updateButtonTapped(_:)), for: .touchUpInside)
        
        cancelButton.setTitle("キャンセル", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleFont(UIFont.systemFont(ofSize: 16, weight: .bold), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setupTextFields() {
        guard let year = selectedYear, let depart = selectedDepart else { return }
        yearTextField.text = SchoolYear.from(rawValue: year).ja()
        departmentTextField.text = Department.from(hash: depart - 200).ja()

        let yearPickerView = UIPickerView()
        let departPickerView = UIPickerView()
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        departPickerView.delegate = self
        departPickerView.dataSource = self
        yearPickerView.tag = 1200
        departPickerView.tag = 1300
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.items = [spacer, doneButton]
        
        yearTextField.inputView = yearPickerView
        yearTextField.inputAccessoryView = toolBar
        departmentTextField.inputView = departPickerView
        departmentTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped(_ sender: Any) {
        if yearTextField.isFirstResponder {
            yearTextField.resignFirstResponder()
        } else if departmentTextField.isFirstResponder {
            departmentTextField.resignFirstResponder()
        }
    }
    
    @objc func updateButtonTapped(_ sender: Any) {
        guard let year = selectedYear, let depart = selectedDepart else { print("zzz"); return }
        print("year: \(year), depart: \(depart)")
        UserModel.updateUser(year: year, depart: depart, onSuccess: { [weak self]() in
            let snackBarMessage = MDCSnackbarMessage()
            snackBarMessage.text = "更新しました. 学年: \(SchoolYear.from(rawValue: year).ja()) 学科: \(Department.from(hash: depart - 200).ja())"
            MDCSnackbarManager.setPresentationHostView(self?.presentingViewController?.view)
            MDCSnackbarManager.show(snackBarMessage)
            self?.dismiss(animated: true, completion: nil)
            
        }, onError: { [weak self] () in
            let snackBarMessage = MDCSnackbarMessage()
            snackBarMessage.text = "更新に失敗しました"
            MDCSnackbarManager.show(snackBarMessage)
            self?.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
