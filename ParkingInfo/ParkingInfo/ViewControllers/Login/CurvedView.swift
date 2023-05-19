//
//  CurvedView.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/02.
//

import UIKit
import SnapKit

class CurvedView: UIView {
    
    var curveHeight: CGFloat = 70.0
    var curvedLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addArc(withCenter: CGPoint(x: CGFloat(rect.width) - curveHeight, y: rect.height), radius: curveHeight, startAngle: 0, endAngle: 1.5 * CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: curveHeight, y: rect.height - curveHeight))
        path.addArc(withCenter: CGPoint(x: curveHeight, y: rect.height - (curveHeight * 2.0)), radius: curveHeight, startAngle: 0, endAngle:  CGFloat.pi, clockwise: true)
        
        path.close()
        
        curvedLayer.path = path.cgPath
        //curvedLayer.fillColor = UIColor(red: 8/255, green: 95/255, blue: 189/255, alpha: 1.0).cgColor
        curvedLayer.frame = rect
        
        let color1 = UIColor(red: 0.22, green: 0.42, blue: 0.99, alpha: 1.00)
        let color2 = UIColor(red: 0.16, green: 0.28, blue: 1.00, alpha: 1.00)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0,1.0]
        
        // make sure to use .cgColor
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.mask = curvedLayer
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.7
        self.clipsToBounds = true
    }
    
    
}
