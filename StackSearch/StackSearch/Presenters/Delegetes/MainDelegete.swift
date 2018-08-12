//
//  MainDelegete.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal protocol MainDelegete {
    
    func loadMore(show: Bool)
    func showProgress(show: Bool)
    func clearItems(completion: @escaping() -> ())
    func addItem(data: Item)
    func showDialog(title: String, message: String)
}
