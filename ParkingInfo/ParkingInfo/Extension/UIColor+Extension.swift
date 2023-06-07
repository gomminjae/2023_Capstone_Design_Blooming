//
//  UIColor+Extensipn.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/23.
//

import UIKit

extension UIColor {
    
    static var redBackground = UIColor(red: 0.96, green: 0.74, blue: 0.75, alpha: 1.00)
    static var redTitle = UIColor(red: 0.86, green: 0.11, blue: 0.07, alpha: 1.00)
    
    static var greenBackground = UIColor(red: 0.77, green: 0.91, blue: 0.72, alpha: 1.00)
    static var greenTitle = UIColor(red: 0.18, green: 0.71, blue: 0.17, alpha: 1.00)
    
    static var blueBackground = UIColor(red: 0.75, green: 0.75, blue: 1.00, alpha: 1.00)
    static var blueTitle = UIColor(red: 0.00, green: 0.00, blue: 1.00, alpha: 1.00)
    
    static var yellowBackground = UIColor(red: 1.00, green: 1.00, blue: 0.69, alpha: 1.00)
    static var yelloTitle = UIColor(red: 1.00, green: 1.00, blue: 0.27, alpha: 1.00)
    
    static var offWhite = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    
    
    
    static func createGradientColor(startColor: UIColor, endColor: UIColor, size: CGSize) -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIColor()
        }
        
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: gradientImage ?? UIImage())
    }
    
    
}
