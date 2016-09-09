//
//  ToothPreviewViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 09/09/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class ToothPreviewViewController: UIViewController {

    
    // MARK: - Interface Builder Outlet
    
    @IBOutlet weak var toothInfoContainer: UIStackView!
    
    @IBOutlet weak var centerButtonIcon: UIImageView!
    
    @IBOutlet weak var toothName: UILabel!
    
    @IBOutlet weak var toothStatus: UILabel!
    
    
    // MARK: - App Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
