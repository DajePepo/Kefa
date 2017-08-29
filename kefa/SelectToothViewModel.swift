//
//  SelectToothViewModel.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class SelectToothViewModel {
    
    // Variables
    let teethDataManager = TeethDataManager()
    var teethViewModelList = [ToothViewModel]()
    
    var selectedTooth = MutableProperty<ToothViewModel?>(nil)
    var isTopBracesSelected = MutableProperty<Bool>(false)
    var isBottomBracesSelected = MutableProperty<Bool>(false)
    
    // Return number of teeth in the list
    var teethCount: Int {
        return teethViewModelList.count
    }
    
    // Return a specific tooth (View Model)
    func teethViewModel(at index: Int) -> ToothViewModel? {
        if 0 ... (teethViewModelList.count - 1) ~= index { return teethViewModelList[index] }
        else { return nil }
    }
    
    func setSelectedTooth(identifier: Int) {
        if let toothModel = teethViewModel(at: identifier) {
            selectedTooth.value = toothModel
        }
    }
    
    // Load teeth list through the data manager
    func retrieveTeeth() {
        
        //let teeth = teethDataManager.retreiveTeeth()
        //self.teethViewModelList = teeth.map(){ /* ... */ }
        
        // Mock
        let names = ["Incisivo", "Incisivo", "Canino", "Premolare", "Premolare", "Molare", "Molare"]
        let status = ["Curato", "Sano", "Cariato"]
        var teeth = [Tooth]()
        for i in 0 ..< 32 {
            let tooth = Tooth(id: i, name: names[Int(arc4random_uniform(7))], status: status[Int(arc4random_uniform(3))])
            teeth.append(tooth)
        }
        
        self.teethViewModelList = teeth.map(){ ToothViewModel(tooth: $0) }
    }

}
