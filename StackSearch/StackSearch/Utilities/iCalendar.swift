//
//  iCalendar.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

@IBDesignable
class iCalendar: UITextField, UITextFieldDelegate {
    
    @IBInspectable var dateFormat: String = "dd/MM/yyyy"
    fileprivate let datePickerView: UIDatePicker = UIDatePicker()
    fileprivate let toolBar: UIToolbar = UIToolbar()
    
    fileprivate func pickerViewSetup() {
        datePickerView.datePickerMode = .date
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func donePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        self.text = dateFormatter.string(from: datePickerView.date)
        self.resignFirstResponder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pickerViewSetup()
        self.delegate = self
        self.isEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.inputView = datePickerView
        self.inputAccessoryView = toolBar
        return true
    }
}
