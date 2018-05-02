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

    @IBOutlet weak var schoolYearTextField: MDCTextField!
    @IBOutlet weak var departmentTextField: MDCTextField!
    @IBOutlet weak var registerButton: MDCButton!
    @IBOutlet weak var backgroundView: MaterialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundView()

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
    }
    
    func setupBackgroundView() {
        backgroundView.layer.cornerRadius = 4
        backgroundView.setElevation()
    }


}

extension RegisterViewController: UITextFieldDelegate {
    
}
