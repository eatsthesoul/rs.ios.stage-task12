//
//  GlassView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.01.22.
//

import UIKit

final class GlassView: UIView, BackgroundViewType {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            updateCornerRadius()
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.babyPowder.withAlphaComponent(0.15).cgColor, UIColor.babyPowder.withAlphaComponent(0.55).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = cornerRadius
        return layer
    }()
    
    private lazy var borderLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.babyPowder.withAlphaComponent(0.15).cgColor, UIColor.babyPowder.withAlphaComponent(0.55).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }()
    
    private var borderShapeLayerMask: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = 1.5
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }()
    
    init(with cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.cornerRadius = cornerRadius
        setupAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.frame = layer.bounds
        gradientLayer.frame = layer.bounds
        
        borderShapeLayerMask.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.mask = borderShapeLayerMask
    }
}

// MARK: - Private methods

private extension GlassView {
    
    func setupAppearance() {
        layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(borderLayer)
        
        backgroundColor = .clear
        layer.cornerRadius = cornerRadius
    }
    
    func updateCornerRadius() {
        gradientLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}


