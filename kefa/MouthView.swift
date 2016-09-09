//
//  TeethView.swift
//  kefa
//
//  Created by Pietro Santececca on 11/04/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

@objc protocol MouthDelegate : AnyObject {
    func tapSingleTooth(gesture: UITapGestureRecognizer)
}

class MouthView: UIView {

    var teeth = [ToothView]()
    var topGum: UIView?
    var bottomGum: UIView?
    var delegate: MouthDelegate?
    let teethNumber = 32
    
    func disactive() {
        for tooth in teeth {
            tooth.disactive()
        }
        topGum?.alpha = 0.25
        bottomGum?.alpha = 0.25
    }
    
    func active() {
        for tooth in teeth {
            tooth.active()
        }
        topGum?.alpha = 1
        bottomGum?.alpha = 1
    }
    
    func drawInTheView(view: UIView) {
        let angleInterval = 180.0 / ((Double(teethNumber) / 2) - 1)
        let radius = topGum!.frame.size.height - 1
        let centerSemiTopCircle = CGPoint(x: topGum!.frame.origin.x + (topGum!.frame.size.width / 2), y: topGum!.frame.origin.y + topGum!.frame.size.height)
        let centerSemiBottomCircle = CGPoint(x: bottomGum!.frame.origin.x + (bottomGum!.frame.size.width / 2), y: bottomGum!.frame.origin.y)
        
        for i in 0 ..< teethNumber {
            
            let pointOnTheCircle: CGPoint?
            var angle = (angleInterval * Double(i)) - 360.0
            
            if Double(i) < (Double(teethNumber) / 2) {
                pointOnTheCircle = Util.getPointOnCircle(Float(radius), center: centerSemiBottomCircle, angle: angle)
            }
            else {
                angle -= angleInterval
                pointOnTheCircle = Util.getPointOnCircle(Float(radius), center: centerSemiTopCircle, angle: angle)
            }
            
            let circleTooth = ToothView(id: Int(i), center: pointOnTheCircle!)
            circleTooth.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(MouthDelegate.tapSingleTooth(_:))))
            teeth.append(circleTooth)
            view.insertSubview(circleTooth, atIndex: 4)
        }
    }
    
}
