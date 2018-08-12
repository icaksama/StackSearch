//
//  ItemController.swift
//  StackSearch
//
//  Created by Saiful I. Wicaksana on 11/08/18.
//  Copyright © 2018 icaksama. All rights reserved.
//

import Foundation
import UIKit
import iProgressHUD

internal class ItemController: UIViewController, ItemDelegete {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagStackView: UIStackView!
    
    fileprivate var util: StackSearchUtil = StackSearchUtil()
    fileprivate var iprogress: iProgressHUD!
    internal var presenter: ItemPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ItemPresenter(delegete: self)
        
        iprogress = iProgressHUD(style: .ballPulseSync)
        iprogress.isShowCaption = false
        iprogress.modalColor = UIColor(rgb: 0x007AFF)
        iprogress.alphaModal = 0.7
        iprogress.isShowBox = false
        iprogress.isShowModal = true
        iprogress.indicatorColor = .white
    }
    
    func setProfile(image: String) {
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 11
        ImageLoader.image(for: URL(string: image)!) { image in
            self.profileImage.image = image
            self.profileImage.dismissProgress()
        }
    }
    
    func setName(creator: String) {
        nameLabel.text = creator
    }
    
    func setReputations(count: Int) {
        reputationLabel.text = "\(count)"
    }
    
    func setViews(count: Int) {
        viewLabel.text = "\(count) views"
    }
    
    func setAnswer(count: Int) {
        answerLabel.text = "\(count) answers"
    }
    
    func setCreated(date: Int) {
        dateLabel.text = "\(util.getDate(miliseconds: date))"
    }
    
    func setQuestion(title: String) {
        titleLabel.text = title
    }
    
    func setQuestion(tags: [String]) {
        for tag in tags {
            let label = UILabel()
            label.textColor = UIColor(rgb: 0x39739d)
            label.backgroundColor = UIColor(rgb: 0xE1ECF4)
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 5
            label.font = label.font.withSize(9)
            label.text = tag
            label.heightAnchor.constraint(equalToConstant: 20).isActive = true
            label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 15).isActive = true
            tagStackView.addArrangedSubview(label)
        }
    }
    
    func getItemView(frame: CGRect) -> UIView {
        self.view.frame = frame
        self.view.layer.borderColor = UIColor(rgb: 0x007AFF).cgColor
        self.view.layer.borderWidth = 0.5
        self.view.layoutSubviews()
        iprogress.attachProgress(toViews: profileImage)
        profileImage.showProgress()
        return self.view
    }
}
