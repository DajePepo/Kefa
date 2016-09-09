//
//  Util.swift
//  kefa
//
//  Created by Pietro Santececca on 12/03/16.
//  Copyright © 2016 Pietro Santececca. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    // This is function receive an image and return a square cropped image
    static func squareImage(image: UIImage) -> UIImage {
        let squareLength = min(image.size.width, image.size.height)
        
        let cropSquare = CGRectMake((image.size.width - squareLength) / 2, (image.size.height - squareLength) / 2, squareLength, squareLength)
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        
        return UIImage(CGImage: imageRef!, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
    }
    
    // This is function receive an image and return a new image whit size equals to targetSize
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func degreesToRadians(degrees: Double) -> Double {
        return degrees * M_PI / 180
    }
    
    static func radiansToDegrees(radians: Double) -> Double {
        return radians * 180 / M_PI
    }
    
    static func getScreenWidth() -> CGFloat {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return screenSize.width
    }
    
    static func getScreenHeight() -> CGFloat {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return screenSize.height
    }
    
    static func encodeEmail(email: String!) -> String {
        var encoded = String()
        encoded = email.stringByReplacingOccurrencesOfString(".", withString: "%@E")
        encoded = encoded.stringByReplacingOccurrencesOfString("$", withString: "%@A")
        encoded = encoded.stringByReplacingOccurrencesOfString("#", withString: "%@B")
        encoded = encoded.stringByReplacingOccurrencesOfString("[", withString: "%@C")
        encoded = encoded.stringByReplacingOccurrencesOfString("]", withString: "%@R")
        encoded = encoded.stringByReplacingOccurrencesOfString("/", withString: "%@Y")
        return encoded
    }
    
    static func decodeEmail(email: String!) -> String {
        var decoded = String()
        decoded = email.stringByReplacingOccurrencesOfString("%@E", withString: ".")
        decoded = decoded.stringByReplacingOccurrencesOfString("%@A", withString: "$")
        decoded = decoded.stringByReplacingOccurrencesOfString("%@B", withString: "#")
        decoded = decoded.stringByReplacingOccurrencesOfString("%@C", withString: "[")
        decoded = decoded.stringByReplacingOccurrencesOfString("%@R", withString: "]")
        decoded = decoded.stringByReplacingOccurrencesOfString("%@Y", withString: "/")
        return decoded
    }
    
    static func getCurrentDate() -> (dayDate: Int, dayName: String, month: String) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month, .Day], fromDate: date)
        let dayNameFormatter = NSDateFormatter()
        dayNameFormatter.locale = NSLocale.currentLocale()
        dayNameFormatter.dateFormat = "EEE"
        let monthNameFormatter = NSDateFormatter()
        monthNameFormatter.locale = NSLocale.currentLocale()
        monthNameFormatter.dateFormat = "MMMM"
        return (components.day, dayNameFormatter.stringFromDate(date), monthNameFormatter.stringFromDate(date))
    }
    
    static func convertToGrayScale(image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        CGContextDrawImage(context, imageRect, image.CGImage)
        let imageRef = CGBitmapContextCreateImage(context)
        let newImage = UIImage(CGImage: imageRef!)
        
        return newImage
    }
    
    static func getPointOnCircle(radius: Float, center: CGPoint, angle: Double) -> CGPoint {
        let theta = Float(Util.degreesToRadians(angle))
        let x = radius * cosf(theta)
        let y = radius * sinf(theta)
        return CGPointMake(CGFloat(x) + center.x, CGFloat(y) + center.y)
    }

    static func distanceBetweenTwoPoints(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let xDist = (p2.x - p1.x)
        let yDist = (p2.y - p1.y)
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}
