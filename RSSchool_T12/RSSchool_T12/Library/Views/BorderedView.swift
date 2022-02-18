//
//  BorderedView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import Foundation

import UIKit

class BorderedView: UIView, BackgroundViewType {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    init(with cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.cornerRadius = cornerRadius
        addBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    
    func addBorder() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.rickBlack.cgColor
        layer.borderWidth = 1
    }
}

