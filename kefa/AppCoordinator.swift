//
//  AppCoordinator.swift
//  kefa
//
//  Created by Pietro Santececca on 04/07/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    func start() {
        
        // Controller
        let navigationController = BaseNavigationController()
        let icon = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), selectedImage: UIImage(named: "homeIcon"))
        navigationController.tabBarItem = icon
        tabBarController?.viewControllers = [navigationController]
        
        // Coordinator
        let coordinator = SelectToothCoordinator(navigationController: navigationController)
        coordinator.start()
        
        // Add coordinator to the childs list
        childCoordinators.append(coordinator)
    }
}
