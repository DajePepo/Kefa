//
//  BaseTabBarController.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set custom layout
        let normalFontAttribute = [NSFontAttributeName : UIFont(name: "Montserrat-Bold", size: 12)!, NSForegroundColorAttributeName : UIColor(red: 228/255, green: 69/255, blue: 73/255, alpha: 1)]
        let selectedFontAttribute = [NSForegroundColorAttributeName:UIColor.white]
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes(normalFontAttribute, for: UIControlState.normal)
        appearance.setTitleTextAttributes(selectedFontAttribute, for:.selected)

        // Set item title & background color
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor(red: 253/255, green: 108/255, blue: 112/255, alpha: 1)
        
        // Set the original color image for the tab bar
//        for item in (self.tabBar.items as NSArray!){
//            (item as! UITabBarItem).image = (item as! UITabBarItem).image?.withRenderingMode(.alwaysOriginal)
//        }
    }
}
