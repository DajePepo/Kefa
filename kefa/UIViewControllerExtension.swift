//
//  UIViewControllerExtension.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

extension UIViewController {

    func setNavigationTitleLayout() {
       
        // Set color of navigation bar title
        if let font = UIFont(name: "Montserrat-Bold", size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white]
        }
    }
}
