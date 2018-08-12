//
//  ItemDelegete.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal protocol ItemDelegete {
    
    func setProfile(image: String)
    func setName(creator: String)
    func setReputations(count: Int)
    func setViews(count: Int)
    func setAnswer(count: Int)
    func setCreated(date: Int)
    func setQuestion(title: String)
    func setQuestion(tags: [String])
    func getItemView(frame: CGRect) -> UIView
}
