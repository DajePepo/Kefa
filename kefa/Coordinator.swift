//
//  Coordinator.swift
//  kefa
//
//  Created by Pietro Santececca on 04/07/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var navigationController: BaseNavigationController?
    weak var tabBarController: BaseTabBarController?
    
    init(navigationController: BaseNavigationController?) {
        self.navigationController = navigationController
    }
    
    init(tabBarController: BaseTabBarController?) {
        self.tabBarController = tabBarController
    }
}
