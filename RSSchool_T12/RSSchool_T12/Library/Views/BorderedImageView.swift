//
//  BorderedImageView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16.02.22.
//

import UIKit

class BorderedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    
    func addBorder() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.rickBlack.cgColor
        layer.borderWidth = 1
    }
}
