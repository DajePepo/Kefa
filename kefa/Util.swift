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
    static func squareImage(_ image: UIImage) -> UIImage {
        let squareLength = min(image.size.width, image.size.height)
        
        let cropSquare = CGRect(x: (image.size.width - squareLength) / 2, y: (image.size.height - squareLength) / 2, width: squareLength, height: squareLength)
        let imageRef = image.cgImage?.cropping(to: cropSquare);
        
        return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
    
    // This is function receive an image and return a new image whit size equals to targetSize
    static func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    
    static func radiansToDegrees(_ radians: Double) -> Double {
        return radians * 180 / .pi
    }
    
    static func getScreenWidth() -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize.width
    }
    
    static func getScreenHeight() -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize.height
    }
    
    static func encodeEmail(_ email: String!) -> String {
        var encoded = String()
        encoded = email.replacingOccurrences(of: ".", with: "%@E")
        encoded = encoded.replacingOccurrences(of: "$", with: "%@A")
        encoded = encoded.replacingOccurrences(of: "#", with: "%@B")
        encoded = encoded.replacingOccurrences(of: "[", with: "%@C")
        encoded = encoded.replacingOccurrences(of: "]", with: "%@R")
        encoded = encoded.replacingOccurrences(of: "/", with: "%@Y")
        return encoded
    }
    
    static func decodeEmail(_ email: String!) -> String {
        var decoded = String()
        decoded = email.replacingOccurrences(of: "%@E", with: ".")
        decoded = decoded.replacingOccurrences(of: "%@A", with: "$")
        decoded = decoded.replacingOccurrences(of: "%@B", with: "#")
        decoded = decoded.replacingOccurrences(of: "%@C", with: "[")
        decoded = decoded.replacingOccurrences(of: "%@R", with: "]")
        decoded = decoded.replacingOccurrences(of: "%@Y", with: "/")
        return decoded
    }
    
    static func getCurrentDate() -> (dayDate: Int, dayName: String, month: String) {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.month, .day], from: date)
        let dayNameFormatter = DateFormatter()
        dayNameFormatter.locale = Locale.current
        dayNameFormatter.dateFormat = "EEE"
        let monthNameFormatter = DateFormatter()
        monthNameFormatter.locale = Locale.current
        monthNameFormatter.dateFormat = "MMMM"
        return (components.day!, dayNameFormatter.string(from: date), monthNameFormatter.string(from: date))
    }
    
    static func convertToGrayScale(_ image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context?.makeImage()
        let newImage = UIImage(cgImage: imageRef!)
        
        return newImage
    }
    
    static func getPointOnCircle(_ radius: Float, center: CGPoint, angle: Double) -> CGPoint {
        let theta = Float(Util.degreesToRadians(angle))
        let x = radius * cosf(theta)
        let y = radius * sinf(theta)
        return CGPoint(x: CGFloat(x) + center.x, y: CGFloat(y) + center.y)
    }

    static func distanceBetweenTwoPoints(_ p1: CGPoint, p2: CGPoint) -> CGFloat {
        let xDist = (p2.x - p1.x)
        let yDist = (p2.y - p1.y)
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}
