//
//  ToothPreviewViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 09/09/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class ToothPreviewViewController: UIViewController {

    // MARK: - Interface Builder Outlet
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var toothInfoContainer: UIStackView!
    @IBOutlet weak var centerButtonIcon: UIImageView!
    @IBOutlet weak var toothName: UILabel!
    @IBOutlet weak var toothStatus: UILabel!
    
    var isActive = MutableProperty<Bool>(false)
    var selectToothViewModel: SelectToothViewModel? // View Model
    
    // MARK: - Class Methods
    
    func configure(viewModel: SelectToothViewModel) {
        infoLabel.isHidden = false
        toothInfoContainer.isHidden = true
        selectToothViewModel = viewModel

        // Binding with view model data
        isActive.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] newValue in
                self?.infoLabel.isHidden = newValue
                self?.toothInfoContainer.isHidden = !newValue
            }
    
        selectToothViewModel!.selectedTooth.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] tooth in
                guard let tooth = tooth else { return }
                self?.isActive.value = true
                self?.setToothInfo(tooth: tooth)
            }
        
        selectToothViewModel!.isBottomBracesSelected.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] isSelected in
                if isSelected {
                    self?.isActive.value = true
                    self?.setBraceInfo()
                }
            }

        selectToothViewModel!.isTopBracesSelected.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] isSelected in
                if isSelected {
                    self?.isActive.value = true
                    self?.setBraceInfo()
                }
        }
    }
    
    // Set the right info into the tooth info containers
    func setToothInfo(tooth: ToothViewModel) {
        toothName.text = tooth.name
        toothStatus.text = tooth.status
        centerButtonIcon.image = UIImage(named: "teethBig")
    }

    // Set the right info into the tooth ingo containers
    func setBraceInfo() {
        toothName.text = "Apparec.."
        toothStatus.text = "Fisso"
        centerButtonIcon.image = UIImage(named: "bracesBig")
    }
}
