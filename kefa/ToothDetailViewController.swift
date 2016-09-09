//
//  ToothDetailViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 20/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class ToothDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set color of navigation bar title
        if let font = UIFont(name: "Montserrat-Bold", size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
    }

    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
