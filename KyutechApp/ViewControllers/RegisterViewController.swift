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

    @IBOutlet weak var schoolYearTextField: MDCTextField!
    @IBOutlet weak var departmentTextField: MDCTextField!
    @IBOutlet weak var registerButton: MDCButton!
    @IBOutlet weak var backgroundView: MaterialView!
    @IBOutlet weak var alartLabel: UILabel!
    
    var selectedYear: Int? = nil
    var selectedDepartment: Int? = nil
    
    let years: [Int] = [SchoolYearKey.one.rawValue, SchoolYearKey.two.rawValue, SchoolYearKey.three.rawValue, SchoolYearKey.four.rawValue]
    
//    ウンコード
    let departments = [Department.classI_I, Department.classI_II, Department.classII_III, Department.classIII_IV, Department.classIII_V, Department.ai, Department.aiIncorp, Department.cse, Department.cseIncorp, Department.mse, Department.mseIncorp, Department.bio, Department.bioIncorp, Department.sys, Department.sysIncorp]
    
    deinit {
        print("\(self) was deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()
        setupTextFields()
        setupButton()
        setupAlartLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTextFields() {
        schoolYearTextField.delegate = self
        departmentTextField.delegate = self
        schoolYearTextField.placeholder = "学年"
        departmentTextField.placeholder = "学科"
        
        let schoolYearTextFieldController = MDCTextInputControllerUnderline(textInput: schoolYearTextField)
        let departmentTextFieldController = MDCTextInputControllerUnderline(textInput: departmentTextField)
        schoolYearTextFieldController.isFloatingEnabled = true
        departmentTextFieldController.isFloatingEnabled = true
        
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
        
        schoolYearTextField.clearButton.addTarget(self, action: #selector(tappedClearButton(_:)), for: .touchUpInside)
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
            UserModel.createUser(year: schoolYear, depart: department, onSuccess: {[weak self] () in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateInitialViewController()
                self?.modalTransitionStyle = .crossDissolve
                self?.present(vc!, animated: true, completion: nil)
                }, onError: { () in
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = ""
        textField.inputView?.reloadInputViews()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField == schoolYearTextField {
                textField.placeholder = "学年"
            } else if textField == departmentTextField {
                textField.placeholder = "学科"
            }
        }
    }
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1200 {
            return years.count
        } else if  pickerView.tag == 1300 {
            return departments.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1200 {
            return (years[row] + 1).description
        } else if pickerView.tag == 1300 {
            return departments[row].ja()
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1200 {
            selectedYear = years[row]
            schoolYearTextField.text = (years[row] + 1).description
        } else if pickerView.tag == 1300 {
            selectedDepartment = departments[row].value()
            departmentTextField.text = departments[row].ja()
        } else {
        }
        resignFirstResponder()

    }
    
}
