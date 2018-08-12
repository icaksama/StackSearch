//
//  iComboBox.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

@IBDesignable
class iComboBox: UITextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBInspectable var simpleData: String = ""
    fileprivate let pickerView: UIPickerView = UIPickerView()
    fileprivate let toolBar: UIToolbar = UIToolbar()
    open var data: [String] = [String]()
    
    fileprivate func pickerViewSetup() {
        for sData in simpleData.components(separatedBy: "|") {
            data.append(sData.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func donePicker() {
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
        self.inputView = pickerView
        self.inputAccessoryView = toolBar
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = data[row]
    }
}
