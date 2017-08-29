//
//  SelectToothCoordinator.swift
//  kefa
//
//  Created by Pietro Santececca on 04/07/2017.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import Foundation
import UIKit

final class SelectToothCoordinator: Coordinator {
    
    func start() {
        
        // View controller
        let storyboard = UIStoryboard(name: "SelectTooth", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"SelectToothViewController") as! SelectToothViewController
        navigationController?.pushViewController(viewController, animated: true)
        
        // View model
        let selectToothViewModel = SelectToothViewModel()
        selectToothViewModel.selectToothCoordinator = self
        viewController.configure(viewModel: selectToothViewModel)
    }
    
    func performTransitionToToothDetail() {

        // View controller
        let storyboard = UIStoryboard(name: "SelectTooth", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ToothDetailViewController") as! ToothDetailViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
