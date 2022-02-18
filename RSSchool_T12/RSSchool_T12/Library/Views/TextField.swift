//
//  TextField.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 20.01.22.
//

import UIKit

class TextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 20, dy: 20)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 20, dy: 20)
    }
    
    private func setupAppearance() {
        font = UIFont.montserrat(24, .semibold)
        textColor = .rickBlack
        
        borderStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeBorderBackground(with: cornerRadius)
    }

}
