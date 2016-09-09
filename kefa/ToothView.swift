//
//  circleToothView.swift
//  kefa
//
//  Created by Pietro Santececca on 13/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

protocol ToothDelegate: class {
    func tapHanlder(id: Int)
}

class ToothView: UIView {
    
    var unselectedSizeFrame:CGSize
    var selectedSizeFrame:CGSize
    var isSelected:Bool
    var circleToothCenter:CGPoint
    var identifier:Int
    let touchAreaRadius:CGFloat = 18
    
    init(id: Int, center: CGPoint) {
        
        identifier = id
        isSelected = false
        selectedSizeFrame = CGSize(width: 30, height: 30)
        unselectedSizeFrame = CGSize(width: 20, height: 20)
        circleToothCenter = center
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: unselectedSizeFrame))
        self.center = circleToothCenter
        
        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 1.5
        layer.cornerRadius = CGRectGetWidth(frame)/2.0
        layer.borderColor = UIColor.grayColor().CGColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select() {
        layer.borderColor = UIColor(red: 79/255, green: 210/255, blue: 194/255, alpha: 1).CGColor
        layer.borderWidth = 2
        layer.cornerRadius = selectedSizeFrame.width/2.0
        self.isSelected = true
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.frame.size = self.selectedSizeFrame
            self.center = self.circleToothCenter
        }) { _ in self.isSelected = true }
    }
    
    func unselect() {
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 1.5
        
//        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.frame.size = self.unselectedSizeFrame
            self.center = self.circleToothCenter
//        }) { _ in
            self.isSelected = false
            self.layer.cornerRadius = self.unselectedSizeFrame.width/2.0
//        }
    }
    
    func disactive() {
        unselect()
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).CGColor
    }
    
    func active() {
        backgroundColor = UIColor.whiteColor()
        layer.borderColor = UIColor.grayColor().CGColor
    }
    
    func pointIsInsideTouchArea(point: CGPoint) -> Bool {
        if point.x < (self.center.x + touchAreaRadius) &&
           point.x > (self.center.x - touchAreaRadius) &&
           point.y < (self.center.y + touchAreaRadius) &&
           point.y > (self.center.y - touchAreaRadius) {
            return true
        }
        else {
            return false
        }
    }


}
