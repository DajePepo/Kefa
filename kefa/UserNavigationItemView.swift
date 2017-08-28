//
//  UserNavigationBarView.swift
//  kefa
//
//  Created by Pietro Santececca on 29/06/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class UserNavigationItemView: UIView {

    // Variables
    var isSelected = false {
        didSet {
            arrowLabel.text = isSelected ? "\u{f077}" : "\u{f078}"
        }
    }
    
    // Actions
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var containerView: UIStackView!
}
