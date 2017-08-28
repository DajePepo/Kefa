//
//  LoginCoordinator.swift
//  kefa
//
//  Created by Pietro Santececca on 8/27/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    func start() {
        
        // View controller
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"LoginViewController") as! LoginViewController
        navigationController?.pushViewController(viewController, animated: true)
        
        // View model
        let loginViewModel = LoginViewModel()
        viewController.configure(viewModel: loginViewModel)
    }
}
