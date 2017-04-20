//
//  CustomTabBarController.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set tab bat item title color
        self.tabBar.tintColor = UIColor.white
        
        // Set the original color image for the tab bar
        for item in (self.tabBar.items as NSArray!){
            (item as! UITabBarItem).image = (item as! UITabBarItem).image?.withRenderingMode(.alwaysOriginal)
        }
    }

}
