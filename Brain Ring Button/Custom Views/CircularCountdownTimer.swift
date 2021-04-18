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
    
    private let startAngle = CGFloat(Double.pi * 1.5)
    private let endAngle = CGFloat(Double.pi * -0.5)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        circleLayer = CAShapeLayer()

        backgroundColor = .clear
        
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 10
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: (min(bounds.width, bounds.height) - 30) / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        circleLayer.path = circlePath.cgPath
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
