//
//  BracesView.swift
//  kefa
//
//  Created by Pietro Santececca on 11/04/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

enum BracesType: Int {
    case Top = 1
    case Bottom = 2
}

class BracesView: UIImageView {
    
    var touchArea = [UIView]()
    var touchAreaDiameter:CGFloat = 18
    var bracesPoints = [UIView]()
    
    func pointIsInsideTouchArea(point: CGPoint) -> Bool {
        for partialTouchArea in touchArea {
            if point.x < (partialTouchArea.center.x + touchAreaDiameter) &&
                point.x > (partialTouchArea.center.x - touchAreaDiameter) &&
                point.y < (partialTouchArea.center.y + touchAreaDiameter) &&
                point.y > (partialTouchArea.center.y - touchAreaDiameter) {
                return true
            }
        }
        return false
    }
    
    func disactive() {
        self.alpha = 0.25
        for point in bracesPoints {
            point.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        }
    }
    
    func active() {
        self.alpha = 1
        for point in bracesPoints {
            point.backgroundColor = UIColor(red: 187/255, green: 186/255, blue: 189/255, alpha: 1)
        }
    }
    
    func getClosestBracePoint(touchPoint: CGPoint) -> CGPoint? {
        var minDistance:CGFloat = 100000
        var closestPoint: CGPoint?
        for point in bracesPoints {
            let distance = Util.distanceBetweenTwoPoints(point.center, p2: touchPoint)
            if distance < minDistance {
                minDistance = distance
                closestPoint = point.center
            }
        }
        return closestPoint
    }
    
    func drawInTheView(view: UIView, numberOfPoints: Int, type: BracesType) {
        
        let angleInterval = 180.0 / Double(numberOfPoints)
        let radius = self.frame.size.height - 1
        var yOffset = self.frame.origin.y
        if type == BracesType.Top { yOffset += self.frame.size.height }
        let bracesArcCenter = CGPoint(x: self.frame.origin.x + (self.frame.size.width / 2), y: yOffset)
        
        // Put points on the arc
        for i in 0 ..< numberOfPoints {
            
            let pointOnTheCircle: CGPoint?
            var angle = (angleInterval * Double(i)) - 180.0
            if type == BracesType.Bottom { angle -= 180 }
            
            let smallCircle = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
            smallCircle.backgroundColor = UIColor(red: 187/255, green: 186/255, blue: 189/255, alpha: 1)
            smallCircle.layer.cornerRadius = CGRectGetWidth(smallCircle.frame)/2.0
            
            
            pointOnTheCircle = Util.getPointOnCircle(Float(radius), center: bracesArcCenter, angle: angle+(angleInterval/2))
            smallCircle.center = pointOnTheCircle!
            bracesPoints.append(smallCircle)
            
            
            view.addSubview(smallCircle)
        }
        
        // Set braces touch area
        for i in 0 ..< 180 {
            
            let pointOnTheCircle: CGPoint?
            var angle = Double(i - 180)
            if type == BracesType.Bottom { angle -= 180 }
            
            pointOnTheCircle = Util.getPointOnCircle(Float(radius + 10), center: bracesArcCenter, angle: angle)
            
            let partialTouchArea = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            partialTouchArea.backgroundColor = UIColor.clearColor()
            partialTouchArea.layer.cornerRadius = CGRectGetWidth(partialTouchArea.frame)/2.0
            partialTouchArea.center = pointOnTheCircle!
            view.addSubview(partialTouchArea)
            touchArea.append(partialTouchArea)
        }
    }
}
