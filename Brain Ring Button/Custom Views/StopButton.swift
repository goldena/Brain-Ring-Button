//
//  RoundedButtonWithShadow.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 10.04.21.
//

import UIKit

class StopButton: UIButton {
    
    // MARK: - Property(s)

    private var layerWithShadow: CAShapeLayer!

    var isShadowEnabled: Bool = true {
        didSet { layerWithShadow.isHidden = !isShadowEnabled }
    }

    private let shadowColor: UIColor = .black
    private var shadowOffset: CGSize = CGSize(width: 10, height: 0)
    private let shadowOpacity: Float = 0.8
    private var shadowRadius: CGFloat = 10

    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        #warning("Start here")
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraints(constraints)
        
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        
        if superview.bounds.width >= superview.bounds.height {
            heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -30).isActive = true
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        } else {
            widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -30).isActive = true
            heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        }

        
        guard isShadowEnabled else { return }
        
        layerWithShadow.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        
        if isEnabled {
            layerWithShadow.fillColor = UIColor.systemGreen.cgColor
        } else {
            layerWithShadow.fillColor = UIColor.systemRed.cgColor
        }

        layerWithShadow.shadowPath = layerWithShadow.path
        layerWithShadow.shadowColor = shadowColor.cgColor
        layerWithShadow.shadowOffset = shadowOffset
        layerWithShadow.shadowOpacity = shadowOpacity
        layerWithShadow.shadowRadius = shadowRadius
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                shadowRadius = 10
                shadowOffset = CGSize(width: 10, height: 0)
            } else {
                shadowRadius = 5
                shadowOffset = CGSize(width: 0, height: 0)
            }
        }
    }
    
    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layerWithShadow = CAShapeLayer()
        layer.insertSublayer(layerWithShadow, at: 0)
    }
}

// MARK: - Utilities


