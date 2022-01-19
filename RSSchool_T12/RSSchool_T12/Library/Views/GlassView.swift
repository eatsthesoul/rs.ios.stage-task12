//
//  GlassView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.01.22.
//

import UIKit

final class GlassView: UIView, BackgroundViewType {
    
    var cornerRadius: CGFloat {
        didSet {
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
    
    private lazy var shadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        layer.shadowRadius = 100
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 1
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
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        setupAppearance()
    }
    
    override init(frame: CGRect) {
        cornerRadius = 0
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        cornerRadius = 0
        super.init(coder: coder)
        setupAppearance()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.frame = layer.bounds
        shadowLayer.frame = layer.bounds
        gradientLayer.frame = layer.bounds
        
        borderShapeLayerMask.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.mask = borderShapeLayerMask
        
        shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}

// MARK: - Private methods

private extension GlassView {
    
    func setupAppearance() {
        layer.insertSublayer(shadowLayer, at: 0)
        layer.insertSublayer(gradientLayer, at: 1)
        layer.addSublayer(borderLayer)
        
        backgroundColor = .clear
        layer.cornerRadius = cornerRadius
    }
    
    func updateCornerRadius() {
        gradientLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
    }
}


