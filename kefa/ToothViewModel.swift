//
//  ToothViewModel.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

class ToothViewModel {
    
    // Variables
    var id: Int
    var name: String
    var status: String
    
    // Initialize the view model through the model
    init(tooth: Tooth) {
        self.id = tooth.id
        self.name = tooth.name
        self.status = tooth.status
    }

}
