//
//  ViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 12/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SelectToothViewController: BaseViewController, MouthDelegate {
    
    // MARK: - Class Attributes
    
    var selectToothViewModel: SelectToothViewModel?
    let mouth = MouthView()
    var lineView = DashLineView()
    var toothPreviewViewController: ToothPreviewViewController?
    var isLayoutReady = false
    
    // MARK: - Interface Builder Outlet
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var topGumView: UIImageView!
    @IBOutlet weak var bottomGumView: UIImageView!
    @IBOutlet weak var topBracesView: BracesView!
    @IBOutlet weak var bottomBracesView: BracesView!
    @IBOutlet weak var toothInfoView: UIView! {
        didSet {
            toothInfoView.backgroundColor = UIColor.white
            toothInfoView.layer.borderWidth = 3
            toothInfoView.layer.borderColor = UIColor(red: 79/255, green: 210/255, blue: 194/255, alpha: 1).cgColor
            toothInfoView.clipsToBounds = true
        }
    }
    
    // MARK: - App Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        showUserNavigationItem = true
        
        // Set sub controller -> Tooth Preview View Controller
        toothPreviewViewController = childViewControllers.first as? ToothPreviewViewController
        toothPreviewViewController?.configure(viewModel: selectToothViewModel!)
    }
    
    override func viewDidLayoutSubviews() {
        if !isLayoutReady { setLayout() }
    }

    func configure(viewModel: SelectToothViewModel) {
        
        selectToothViewModel = viewModel

        // Set this class as delegate for month view
        mouth.delegate = self
        
        // Retreive teeth
        selectToothViewModel!.retrieveTeeth()
    }
    
    func setLayout() {
        
        guard let selectToothViewModel = selectToothViewModel else { return }
        
        // Add gums in the mouth
        mouth.topGum = topGumView
        mouth.bottomGum = bottomGumView
        
        // Set conrner radius of central button
        toothInfoView.layer.cornerRadius = toothInfoView.frame.width / 2.0
        
        // Add teeth in the mouth
        mouth.drawInTheView(self.view, numberOfTeeth: selectToothViewModel.teethCount)
        
        // Add points in the top braces
        topBracesView.drawInTheView(self.view, numberOfPoints: (selectToothViewModel.teethCount / 2), type: BracesType.top)
        
        // Add points in the bottom braces
        bottomBracesView.drawInTheView(self.view, numberOfPoints: (selectToothViewModel.teethCount / 2), type: BracesType.bottom)
        
        // Disable braces
        topBracesView.disable()
        bottomBracesView.disable()
        
        isLayoutReady = true
    }

    // MARK: - Methods to catch user gestures
    
    @IBAction func swipeTooth(_ gesture: UIPanGestureRecognizer) {
        
        guard let selectToothViewModel = selectToothViewModel else { return }
        
        let translation = gesture.location(in: self.view)
        
        // If point is inside the top braces
        if topBracesView.pointIsInsideTouchArea(translation) {
            selectToothViewModel.isTopBracesSelected.value = true
            moveToBraces(translation, bracesView: topBracesView)
            return
        }
        
        // Else if point is inside the bottom braces
        if bottomBracesView.pointIsInsideTouchArea(translation) {
            selectToothViewModel.isBottomBracesSelected.value = true
            moveToBraces(translation, bracesView: bottomBracesView)
            return
        }
            
        // Else if point is inside the mouth (teeth) -> Select the tapped tooth
        for tooth in mouth.teeth {
            if tooth.pointIsInsideTouchArea(translation) {
                selectToothViewModel.setSelectedTooth(identifier: tooth.identifier)
                moveToTooth(tooth)
                return
            }
        }
    }
    
    func tapSingleTooth(_ gesture: UITapGestureRecognizer) {
        guard let selectToothViewModel = selectToothViewModel else { return }

        let tooth = gesture.view as! ToothView
        selectToothViewModel.setSelectedTooth(identifier: tooth.identifier)
        moveToTooth(tooth)
    }
    
    // MARK: - Methods to update views
    
    func moveToBraces(_ point: CGPoint, bracesView: BracesView) {
        
        // Disable mouth and braces views
        mouth.disable()
        bottomBracesView.disable()
        topBracesView.disable()
        
        // Enable the selected braces
        bracesView.enable()
        let anchorPoint = bracesView.getClosestBracePoint(point)
        
        // Create a dashed line to link tooth info container with the selected braces
        createLink(withBraces: anchorPoint)
    }
    
    func moveToTooth(_ tooth: ToothView) {
        
        // Disable top and bottom braces
        topBracesView.disable()
        bottomBracesView.disable()
        
        // Enable mouth and deselect all the teeth
        mouth.enable()
        mouth.deselectAllTeeth()
        
        // Select the tapped tooth
        tooth.select()
        
        // Create a dashed line to link tooth info container with the selected tooth
        createLink(withTooth: tooth.center)
    }
    
    func createLink(withTooth destinationPoint: CGPoint?) {
        createLink(destinationPoint)
        view.layer.insertSublayer(lineView, at: 4)
    }
    
    func createLink(withBraces destinationPoint: CGPoint?) {
        createLink(destinationPoint)
        view.layer.insertSublayer(lineView, below: toothInfoView.layer)
    }
    
    func createLink(_ destinationPoint: CGPoint?) {
        lineView.removeFromSuperlayer()
        lineView.drawLine(from: toothInfoView.center, to: destinationPoint ?? CGPoint.zero)
    }
}

