//
//  Owner.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation

internal struct Owner: Codable {
    internal let reputation: Int?
    internal let user_id: Int?
    internal let user_type: String
    internal let profile_image: String?
    internal let display_name: String?
    internal let link: String?
}
