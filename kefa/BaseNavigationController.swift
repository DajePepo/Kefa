//
//  BaseNavigationController.swift
//  kefa
//
//  Created by Pietro Santececca on 04/07/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Bar background color
        self.navigationBar.barTintColor = UIColor(red: 253/255, green: 108/255, blue: 112/255, alpha: 1)
        self.navigationBar.isTranslucent = false
        
        // Title font and color
        if let font = UIFont(name: "Montserrat-Bold", size: 18) {
            self.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
    }
}
