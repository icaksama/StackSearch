//
//  ItemPresenter.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import UIKit

internal class ItemPresenter {
    
    fileprivate var delegete: ItemDelegete!
    
    init(delegete: ItemDelegete) {
        self.delegete = delegete
    }
    
    /** Add data items. */
    func addData(data: Item, frame: CGRect) -> UIView {
        if data.owner.user_type == "registered" {
            delegete.setProfile(image: data.owner.profile_image!)
            delegete.setReputations(count: data.owner.reputation!)
        } else {
            delegete.setProfile(image: "https://lh3.googleusercontent.com/-IGU175kqAWs/AAAAAAAAAAI/AAAAAAAAANk/DRuXNAtyS9A/photo.jpg?sz=128")
            delegete.setReputations(count: 0)
        }
        delegete.setName(creator: data.owner.display_name!)
        delegete.setViews(count: data.view_count)
        delegete.setAnswer(count: data.answer_count)
        delegete.setCreated(date: data.creation_date)
        delegete.setQuestion(title: data.title)
        delegete.setQuestion(tags: data.tags)
        return delegete.getItemView(frame: frame)
    }
}
