//
//  ColorTheme.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

@objc public enum ColorTheme: Int32, CaseIterable {
    case blueSky, goldenHour, goldenSands, morningSky, seaWave
}

extension ColorTheme {
    var image: UIImage {
        switch self {
        case .blueSky:
            return .blueSky
        case .goldenHour:
            return .goldenHour
        case .goldenSands:
            return .goldenSands
        case .morningSky:
            return .morningSky
        case .seaWave:
            return .seaWave
        }
    }
}
