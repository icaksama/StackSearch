//
//  MainPresenter.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal class MainPresenter: MainPresenterDelegete {
    
    fileprivate let TAG = "MainPresenter"
    fileprivate var delegete: MainDelegete!
    fileprivate var util: StackSearchUtil = StackSearchUtil()
    fileprivate var apiParamObj: APIParams = APIParams()
    fileprivate var model: MasterModel!
    fileprivate var pagination: Int = 2
    
    init(delegete: MainDelegete) {
        self.delegete = delegete
        delegete.showProgress(show: true)
        requestItems { (success) in
            self.delegete.showProgress(show: false)
            if !success {
                self.delegete.showDialog(title: "Error", message: "Request data failed! Please try another topics.")
            }
        }
    }
    
    internal func getItems() -> [Item] {
        return model.items
    }
    
    func showDialog(title: String, message: String) {
        delegete.showDialog(title: title, message: message)
    }
    
    /** Open stackoverflow question in browser  */
    internal func openBrowser(link: String) {
        UIApplication.shared.open(URL(string : link)!, options: [:], completionHandler: { (status) in
            print("Link openend: \(link)")
        })
    }
    
    internal func requestNextPage() {
        if model.has_more {
            delegete.loadMore(show: true)
            requestItems(page: pagination, completion: { (success) in
                if success {
                    self.delegete.loadMore(show: false)
                    self.pagination += 1
                } else {
                    self.delegete.loadMore(show: false)
                    self.delegete.showDialog(title: "Info", message: "Request data failed! Please try another topics.")
                }
            })
        }
    }
    
    /** Request items from API and convert to view. */
    internal func requestItems(page: Int = 1, completion: @escaping(_ success: Bool) -> ()) {
        let url = util.getAPI(apiParams: apiParamObj, page: page)
        print("URL: \(url)")
        util.requestData(url: url) { (data) in
            do {
                self.model = try JSONDecoder().decode(MasterModel.self, from: data)
                if page == 1 {
                    self.delegete.clearItems {
                        for item in self.model.items {
                            self.delegete.addItem(data: item)
                        }
                    }
                } else {
                    for item in self.model.items {
                        self.delegete.addItem(data: item)
                    }
                }
                completion(true)
            } catch let error {
                completion(false)
                print("\(self.TAG) - requestItems: \(error)")
            }
        }
    }
    
    func filterResult(apiParams: APIParams) {
        pagination = 2
        apiParamObj = apiParams
        delegete.showProgress(show: true)
        requestItems(page: 1) { (success) in
            self.delegete.showProgress(show: false)
            if !success {
                self.delegete.showDialog(title: "Error", message: "Request data failed! Please try another topics.")
            }
        }
    }
}
