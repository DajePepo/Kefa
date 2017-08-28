//
//  LoginViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 8/27/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
    var loginViewModel: LoginViewModel?
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField! {
        didSet {
            emailTextField.tintColor = UIColor(colorLiteralRed: 71/255, green: 210/255, blue: 191/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!{
        didSet {
            passwordTextField.tintColor = UIColor(colorLiteralRed: 71/255, green: 210/255, blue: 191/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var emailIcon: UILabel! {
        didSet {
            emailIcon.text = "\u{f003}"
        }
    }
    
    @IBOutlet weak var passwordIcon: UILabel! {
        didSet {
            passwordIcon.text = "\u{f023}"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(viewModel: LoginViewModel) {
        
        loginViewModel = viewModel
        
        //...
    }
}
