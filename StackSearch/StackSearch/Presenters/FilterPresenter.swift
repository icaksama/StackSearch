//
//  FilterPresenter.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal class FilterPresenter {
    
    fileprivate var delegete: FilterDelegete!
    internal var mainDelegete: MainPresenterDelegete!
    
    init(delegete: FilterDelegete) {
        self.delegete = delegete
    }
    
    /** Initialize presenter. */
    init(delegete: FilterDelegete, mainDelegete: MainPresenterDelegete) {
        self.delegete = delegete
        self.mainDelegete = mainDelegete
    }
    
    /** Search button action click. */
    internal func searchAction() {
        self.mainDelegete.filterResult(apiParams: delegete.getAPIParams())
    }
}
