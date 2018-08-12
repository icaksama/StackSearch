//
//  FilterController.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit

internal class FilterController: UIViewController, FilterDelegete {
    
    @IBOutlet weak var inputTopic: iTextField!
    @IBOutlet weak var inputTag: iTextField!
    @IBOutlet weak var fromCalendar: iCalendar!
    @IBOutlet weak var toCalendar: iCalendar!
    @IBOutlet weak var sortComboBox: iComboBox!
    @IBOutlet weak var orderComboBox: iComboBox!
    @IBOutlet weak var totalResultsComboBox: iComboBox!
    
    fileprivate let util: StackSearchUtil = StackSearchUtil()
    fileprivate let apiParams: APIParams = APIParams()
    fileprivate var presenter: FilterPresenter!
    
    internal var mainDelegete: MainPresenterDelegete!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FilterPresenter(delegete: self, mainDelegete: mainDelegete)
        
        // Set value from userdefaults local storage
        inputTopic.text = apiParams.intitle
        inputTag.text = apiParams.tagged
        fromCalendar.text = apiParams.fromdate == 0 ? "" : "\(util.getDate(miliseconds: apiParams.fromdate))"
        toCalendar.text = apiParams.todate == 0 ? "" : "\(util.getDate(miliseconds: apiParams.todate))"
        sortComboBox.text = apiParams.sort
        orderComboBox.text = apiParams.order
        totalResultsComboBox.text = "\(apiParams.pagesize)"
    }
    
    @IBAction func didClickReset(_ sender: Any) {
        inputTopic.text = "ios"
        inputTag.text = ""
        fromCalendar.text = ""
        toCalendar.text = ""
        sortComboBox.text = "Activity"
        orderComboBox.text = "Desc"
        totalResultsComboBox.text = "10"
    }
    
    @IBAction func didClickSearch(_ sender: Any) {
        if inputTopic.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            mainDelegete.showDialog(title: "Warning", message: "Please fill the topics!")
        } else {
            presenter.searchAction()
        }
    }
    
    func getAPIParams() -> APIParams {
        let fromDate: Int = fromCalendar.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? 0 : Int(util.getDate(string: fromCalendar.text!).timeIntervalSince1970)
        let toDate: Int = toCalendar.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? 0 : Int(util.getDate(string: toCalendar.text!).timeIntervalSince1970)
        return APIParams(pagesize: Int(totalResultsComboBox.text!)!, fromdate: fromDate, todate: toDate, order: orderComboBox.text!.lowercased(), sort: sortComboBox.text!.lowercased(), tagged: inputTag.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), intitle: inputTopic.text!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
    }
    
}
