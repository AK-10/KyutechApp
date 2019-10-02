//
//  RegisterViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/25.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class RegisterViewController: UIViewController {
    
    typealias Parameters = [String:Any]

    @IBOutlet weak var schoolYearTextField: PickeredTextField!
    @IBOutlet weak var departmentTextField: PickeredTextField!
    @IBOutlet weak var registerButton: MDCButton!
    @IBOutlet weak var backgroundView: MaterialView!
    @IBOutlet weak var alartLabel: UILabel!
    
    var indicator = ActivityIndicatorWithBackground()
    
    var selectedYear: Int? = Const.years.first?.rawValue
    var selectedDepartment: Int? = Const.departments.first?.value()
    
    let years: [SchoolYear] = Const.years
    
    let departments = Const.departments
    
    deinit {
        print("\(self) was deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupTextFields()
        setupButton()
        setupAlartLabel()
        setupIndicator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTextFields() {
        schoolYearTextField.placeholder = "学年"
        schoolYearTextField.text = years.first?.ja()
        departmentTextField.placeholder = "学科"
        departmentTextField.text = departments.first?.ja()
        
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
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(tappedDoneButton(_:)))
        toolBar.items = [spacer, doneButton]
        
        schoolYearTextField.inputView = yearPickerView
        schoolYearTextField.inputAccessoryView = toolBar
        departmentTextField.inputView = departPickerView
        departmentTextField.inputAccessoryView = toolBar
        
    }
    
    func setupIndicator() {
        self.view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(indicator)
    }
    
    func setupAlartLabel() {
        alartLabel.alpha = 0
        alartLabel.text = "入力欄を全て埋めてください"
        alartLabel.textColor = .red
    }
    
    func setupButton() {
        registerButton.addTarget(self, action: #selector(tappedRegisterButton(_:)), for: .touchUpInside)
    }
    
    @objc func tappedRegisterButton(_ sender: Any) {
        if let schoolYear = selectedYear, let department = selectedDepartment {
            indicator.startAnimating()
            UserModel.createUser(year: schoolYear, depart: department, onSuccess: {[weak self] () in
                self?.indicator.stopAnimating()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateInitialViewController()
                vc?.modalPresentationStyle = .fullScreen
                self?.modalTransitionStyle = .crossDissolve
                self?.present(vc!, animated: true, completion: nil)
                }, onError: { [weak self] () in
                    self?.indicator.stopAnimating()
                    let snackMessage = MDCSnackbarMessage()
                    snackMessage.duration = 2
                    snackMessage.text = "登録に失敗しました. 通信状況を確認してください."
                    MDCSnackbarManager.setPresentationHostView(self?.view)
                    MDCSnackbarManager.show(snackMessage)
                    print("cannot register")
            })
        } else {
            print("invalid input")
            alartLabel.alpha = 1
        }
    }
    
    @objc func tappedClearButton(_ sender: UIButton) {
        if sender.superview == schoolYearTextField {
            selectedYear = nil
        } else if sender.superview == departmentTextField {
            selectedDepartment = nil
        } else { return }
    }
    
    func setupBackgroundView() {
        backgroundView.layer.cornerRadius = 4
        backgroundView.setElevation()
    }

    @objc func tappedDoneButton(_ sender: Any) {
        if schoolYearTextField.isFirstResponder {
            schoolYearTextField.resignFirstResponder()
        } else if departmentTextField.isFirstResponder {
            departmentTextField.resignFirstResponder()
        } else { return }
    }
}



