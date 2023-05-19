//
//  UIView+Extension.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/02.
//

import UIKit

extension UIView {
    func setGradient() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let color1 = UIColor(red: 0.22, green: 0.42, blue: 0.99, alpha: 1.00)
        let color2 = UIColor(red: 0.16, green: 0.28, blue: 1.00, alpha: 1.00)
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        layer.insertSublayer(gradient, at: 0)
    }
}
