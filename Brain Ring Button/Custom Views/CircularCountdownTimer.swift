//
//  CircularCountdownTimer.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 18.04.21.
//

import UIKit

class CircularCountdownTimer: UIView {

    var proportionOfCircle: CGFloat {
        get { circleLayer.strokeEnd }
        set { circleLayer.strokeEnd = newValue }
    }
    
    private var circleLayer: CAShapeLayer!
    
    private let startAngle = CGFloat(Double.pi * 2.0)
    private let endAngle = CGFloat(0.0)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .clear
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.width, y: frame.height),
            radius: (frame.width - 10) / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 10
        
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
}    
    
//    private lazy var progressLayer: CAShapeLayer = {
//        let progressLayer = CAShapeLayer()
//
//        progressLayer.strokeColor = UIColor.blue.cgColor
//        progressLayer.fillColor = UIColor.clear.cgColor
//        progressLayer.lineWidth = strokeWidth
//
//        self.layer.addSublayer(progressLayer)
//
//        return progressLayer
//    }()
