//
//  ViewController.swift
//  kefa
//
//  Created by Pietro Santececca on 12/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MouthDelegate {
    
    
    // MARK: - Class Attributes
    
    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    var isFirstTime = true
    var alreadyOnTopBraces = false
    var alreadyOnBottomBraces = false
    var teeth: [Int:Tooth]!
    let teethNumber = 32.0
    var mouth = MouthView()
    
    
    // MARK: - Interface Builder Outlet
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet weak var semiTopCircle: UIImageView!
    
    @IBOutlet weak var semiBottomCircle: UIImageView!
    
    @IBOutlet weak var toothInfoButton: UIButton!
    
    @IBOutlet weak var toothName: UILabel!
    
    @IBOutlet weak var toothStatus: UILabel!
    
    @IBOutlet weak var topDentalApplianceView: BracesView!
    
    @IBOutlet weak var centerButtonIcon: UIImageView!
    
    @IBOutlet weak var bottomDentalApplianceView: BracesView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var toothInfoContainer: UIStackView!
    
    @IBOutlet weak var centreButtonBackground: UIView! {
        didSet {
            centreButtonBackground.backgroundColor = UIColor.whiteColor()
            centreButtonBackground.layer.borderWidth = 3
            centreButtonBackground.layer.borderColor = UIColor(red: 79/255, green: 210/255, blue: 194/255, alpha: 1).CGColor
            centreButtonBackground.clipsToBounds = true
        }
    }
    
    
    // MARK: - App Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set color of navigation bar title
        if let font = UIFont(name: "Montserrat-Bold", size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        // Set tab bat item title color
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        // Set the original color image for the tab bar
        for item in (self.tabBarController?.tabBar.items as NSArray!){
            (item as! UITabBarItem).image = (item as! UITabBarItem).image?.imageWithRenderingMode(.AlwaysOriginal)
        }
        
        // Set this class as delegate for month view
        mouth.delegate = self
        
        // Show info label instead of tooth detail
        infoLabel.hidden = false
        toothInfoContainer.hidden = true
        
        // Get teeth from local source (TO UPDATE)
        teeth = getTeeth()
    }
    
    override func viewDidLayoutSubviews() {
        
        // Just one time (the first one)
        if isFirstTime {
            
            centreButtonBackground.layer.cornerRadius = CGRectGetWidth(centreButtonBackground.frame) / 2.0
            
            // Add gums in the mouth
            mouth.topGum = semiTopCircle
            mouth.bottomGum = semiBottomCircle
            
            // Add teeth in the mouth
            mouth.drawInTheView(self.view)
            
            // Add points in the top braces
            topDentalApplianceView.drawInTheView(self.view, numberOfPoints: Int(teethNumber / 2), type: BracesType.Top)
            
            // Add points in the bottom braces
            bottomDentalApplianceView.drawInTheView(self.view, numberOfPoints: Int(teethNumber / 2), type: BracesType.Bottom)
            
            // Design the path
            //path.moveToPoint(centreButtonBackground.center)
            //path.addLineToPoint(mouth.teeth[2].center)
            
            // Design path in layer
            shapeLayer.path = path.CGPath
            shapeLayer.strokeColor = UIColor(red: 79/255, green: 210/255, blue: 194/255, alpha: 1).CGColor
            shapeLayer.lineDashPattern = [0.0, 16.0]
            shapeLayer.lineDashPhase = 6.0
            shapeLayer.lineCap = kCALineCapRound
            shapeLayer.lineWidth = 6.0
            view.layer.insertSublayer(shapeLayer, atIndex: 4)
            //view.layer.insertSublayer(shapeLayer, below: centreButtonBackground.layer)
        
            // Disactive braces
            topDentalApplianceView.disactive()
            bottomDentalApplianceView.disactive()
        
            isFirstTime = false
        }
    }

    
    // MARK: - Interface Builder Action
    
    @IBAction func swipeTooth(gesture: UIPanGestureRecognizer) {
        infoLabel.hidden = true
        toothInfoContainer.hidden = false

        let translation = gesture.locationInView(self.view)
        
        // If point is inside the top braces
        if topDentalApplianceView.pointIsInsideTouchArea(translation) {
            if !alreadyOnTopBraces { moveToBraces(translation, type: BracesType.Top) }
        }
        
        // Else if point is inside the bottom braces
        else if bottomDentalApplianceView.pointIsInsideTouchArea(translation) {
            if !alreadyOnBottomBraces { moveToBraces(translation, type: BracesType.Bottom) }
        }
            
        // Else if point is inside the mouth (teeth)
        else {
            for tooth in mouth.teeth {
                if tooth.pointIsInsideTouchArea(translation) {
                    self.view.removeGestureRecognizer(gesture)
                    moveToTooth(tooth)
                    self.view.addGestureRecognizer(gesture)
                }
            }
        }
    }
    
    func tapSingleTooth(gesture: UITapGestureRecognizer) {
        infoLabel.hidden = true
        toothInfoContainer.hidden = false

        let tooth = gesture.view as! ToothView
        moveToTooth(tooth)
    }
    
    func moveToBraces(point: CGPoint, type: BracesType) {
        
        var anchorPoint: CGPoint?
        
        // Unselect tooth
        for tooth in mouth.teeth {
            if tooth.isSelected {
                tooth.unselect()
            }
        }
        
        // Active the right braces, disactive mouth
        if type == .Top {
            alreadyOnTopBraces = true
            alreadyOnBottomBraces = false
            topDentalApplianceView.active()
            bottomDentalApplianceView.disactive()
            anchorPoint = topDentalApplianceView.getClosestBracePoint(point)
        }
        else if type == .Bottom {
            alreadyOnTopBraces = false
            alreadyOnBottomBraces = true
            bottomDentalApplianceView.active()
            topDentalApplianceView.disactive()
            anchorPoint = bottomDentalApplianceView.getClosestBracePoint(point)
        }
        mouth.disactive()
        
        // Update the dashed line direction
        path.removeAllPoints()
        path.moveToPoint(centreButtonBackground.center)
        path.addLineToPoint(anchorPoint!)
        shapeLayer.path = path.CGPath
        view.layer.insertSublayer(shapeLayer, below: centreButtonBackground.layer)
        
        // Update name and info of the tooth shown in the big white circle
        toothName.text = "Apparec.."
        toothStatus.text = "Fisso"
        centerButtonIcon.image = UIImage(named: "bracesBig")
    }
    
    func moveToTooth(tooth: ToothView) {
        
        alreadyOnTopBraces = false
        alreadyOnBottomBraces = false
        
        // Active mouth, disactive top and bottom braces
        topDentalApplianceView.disactive()
        bottomDentalApplianceView.disactive()
        mouth.active()
        
        // Update the dashed line direction
        path.removeAllPoints()
        path.moveToPoint(centreButtonBackground.center)
        path.addLineToPoint(tooth.center)
        shapeLayer.path = path.CGPath
        view.layer.insertSublayer(shapeLayer, atIndex: 4)
        
        // Select the tooth
        tooth.select()
        
        // Unselect all the others
        for otherTooth in mouth.teeth {
            if otherTooth.identifier != tooth.identifier && otherTooth.isSelected {
                otherTooth.unselect()
            }
        }
        
        // Update name and info of the tooth shown in the big white circle
        toothName.text = teeth[tooth.identifier]?.name
        toothStatus.text = teeth[tooth.identifier]?.status
        centerButtonIcon.image = UIImage(named: "teethBig")
    }
    
    
    
    // To get random (and fake) info for the teeth
    func getTeeth() -> [Int:Tooth] {
        
        var result = [Int:Tooth]()
        let names = ["Incisivo", "Incisivo", "Canino", "Premolare", "Premolare", "Molare", "Molare"]
        let status = ["Curato", "Sano", "Cariato"]
        
        for i in 0 ..< Int(teethNumber) {
            let tooth = Tooth(id: i, name: names[Int(arc4random_uniform(7))], status: status[Int(arc4random_uniform(3))])
            result[i] = tooth
        }
        return result
    }

}

