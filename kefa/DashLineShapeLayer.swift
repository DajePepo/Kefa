//
//  DottedLineShapeLayer.swift
//  kefa
//
//  Created by Pietro Santececca on 17/02/17.
//  Copyright © 2017 Pietro Santececca. All rights reserved.
//

import UIKit

class DashLineView: CAShapeLayer {
    
    override init() {
        super.init()
        self.strokeColor = UIColor(red: 79/255, green: 210/255, blue: 194/255, alpha: 1).cgColor
        self.lineDashPattern = [0.0, 16.0]
        self.lineDashPhase = 6.0
        self.lineCap = kCALineCapRound
        self.lineWidth = 6.0
    }
    
    func drawLine(from initialPoint: CGPoint, to finalPoint: CGPoint) {
        let linePath = UIBezierPath()
        linePath.removeAllPoints()
        linePath.move(to: initialPoint)
        linePath.addLine(to: finalPoint)
        self.path = linePath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
