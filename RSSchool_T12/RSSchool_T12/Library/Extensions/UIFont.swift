//
//  UIFont.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 5.01.22.
//

import UIKit

extension UIFont {
    
    enum FontWeight: String {
        case semibold
        case medium
        case regular
    }
    
    static func montserrat(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        UIFont(name: "Montserrat-\(weight.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
}
