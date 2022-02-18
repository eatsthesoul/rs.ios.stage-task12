//
//  TextView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.02.22.
//

import UIKit

class TextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupAppearance()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

    private func setupAppearance() {
        textColor = .rickBlack
        textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layer.borderColor = UIColor.rickBlack.cgColor
        layer.borderWidth = 1
    }
}
