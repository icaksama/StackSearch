//
//  MasterModel.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct MasterModel: Codable {
    internal let items: [Item]
    internal let has_more: Bool
    internal let quota_max: Int
    internal let quota_remaining: Int
}
