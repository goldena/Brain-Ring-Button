//
//  CircularCountdownTimer.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 18.04.21.
//

import UIKit

class CircularCountdownTimer: UIView {

    // MARK: - Property(s)
    
    var proportionOfCircle: CGFloat {
        get { circleLayer.strokeEnd }
        set { circleLayer.strokeEnd = newValue }
    }
    
    private var circleLayer: CAShapeLayer!
    
    private let startAngle = CGFloat(Double.pi * 1.5)
    private let endAngle = CGFloat(Double.pi * -0.5)
    private let padding = CGFloat(30)
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: (min(bounds.width, bounds.height) - padding) / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        circleLayer.path = circlePath.cgPath
    }
    
    // MARK: - Init
    
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
}
