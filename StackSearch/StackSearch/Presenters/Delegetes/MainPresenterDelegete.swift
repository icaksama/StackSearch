//
//  MainPresenterDelegete.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 12/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal protocol MainPresenterDelegete {
    
    func filterResult(apiParams: APIParams)
    func showDialog(title: String, message: String)
}
