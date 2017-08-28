//
//  ToothDetailViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 20/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class ToothDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

}
