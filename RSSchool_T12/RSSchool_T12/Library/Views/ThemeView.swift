//
//  BackgroundView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

class ThemeView: UIImageView, BackgroundViewType {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
