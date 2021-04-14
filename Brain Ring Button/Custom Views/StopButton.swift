//
//  RoundedButtonWithShadow.swift
//  Brain Ring Button
//
//  Created by Denis Goloborodko on 10.04.21.
//

import UIKit

final class StopButton: UIButton {
    
    // MARK: - Property(s)

    private var layerWithShadow: CAShapeLayer!

    var cornerRadius: CGFloat = 8

    var isShadowEnabled: Bool = true {
        didSet { layerWithShadow.isHidden = !isShadowEnabled }
    }

    var shadowColor: UIColor = .black
    var shadowOffset: CGSize = CGSize(width: 10.0, height: 10.0)
    var shadowOpacity: Float = 0.8
    var shadowRadius: CGFloat = 10

    // MARK: - View Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = cornerRadius

        guard isShadowEnabled else { return }

        layerWithShadow.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layerWithShadow.fillColor = UIColor.systemGreen.cgColor

        layerWithShadow.shadowPath = layerWithShadow.path
        layerWithShadow.shadowColor = shadowColor.cgColor
        layerWithShadow.shadowOffset = shadowOffset
        layerWithShadow.shadowOpacity = shadowOpacity
        layerWithShadow.shadowRadius = shadowRadius
    }

    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layerWithShadow = CAShapeLayer()
        layer.insertSublayer(layerWithShadow, at: 0)
    }
}
