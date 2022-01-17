//
//  BarButton.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 13.01.22.
//

import UIKit

class BarButton: UIButton {
    
    @objc enum Style: Int {
        case normal = 0
        case destructive
    }
    
    var style: Style = .normal {
        didSet {
            setColors()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setColors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setColors()
    }
    
    override var isHighlighted: Bool {
        willSet {
            if newValue {
                imageView?.tintColor = .deepSaffron
                tintColor = .deepSaffron
            }
            else {
                setColors()
            }
        }
    }
    
    private func setColors() {
        var color: UIColor
        switch style {
        case .normal:
            color = .greenBlueCrayola
        case .destructive:
            color = .amaranthRed
        }
        imageView?.tintColor = color
        tintColor = color
    }
}
