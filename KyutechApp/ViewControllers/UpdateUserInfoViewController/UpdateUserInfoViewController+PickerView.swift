//
//  UpdateUserInfoViewController+PickerView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit


extension UpdateUserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
            yearTextField.text = (years[row] + 1).description
        } else if pickerView.tag == 1300 {
            selectedDepart = departments[row].value() // ex: 203
            departmentTextField.text = departments[row].ja()
        } else {
        }
        resignFirstResponder()
    }
    
}
