//
//  UIView+Extension.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/02.
//

import UIKit

extension UIView {
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
