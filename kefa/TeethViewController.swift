//
//  TeethViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class TeethViewController: UIViewController {
    
    var selectToothViewController: SelectToothViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitleLayout()
        
        // Sub controller -> Select Tooth View Controller
        selectToothViewController = childViewControllers.first as? SelectToothViewController
        selectToothViewController?.configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
