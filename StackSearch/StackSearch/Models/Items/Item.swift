//
//  Item.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct Item: Codable {
    internal let tags: [String]
    internal let owner: Owner
    internal let is_answered: Bool
    internal let view_count: Int
    internal let answer_count: Int
    internal let score: Int
    internal let last_activity_date: Int
    internal let creation_date: Int
    internal let last_edit_date: Int?
    internal let question_id: Int
    internal let link: String
    internal let title: String
}
