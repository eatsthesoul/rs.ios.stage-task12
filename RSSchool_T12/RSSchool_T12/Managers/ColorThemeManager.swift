//
//  ColorThemeManager.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

protocol ColorThemeManagerProtocol {
    func getTheme() -> ColorTheme?
    func setTheme()
    func setTheme(_ theme: ColorTheme)
    func setRandomTheme()
}

class ColorThemeManager: ColorThemeManagerProtocol {
    
    private static var colorTheme: ColorTheme? {
        didSet {
            BackgroundView.appearance().image = colorTheme?.image
        }
    }
    
    func getTheme() -> ColorTheme? {
        ColorThemeManager.colorTheme
    }
    
    func setTheme() {
        //TODO: Request to data base to get setted theme
        setRandomTheme()  //if we don't get theme from data base
    }
    
    func setTheme(_ theme: ColorTheme) {
        ColorThemeManager.colorTheme = theme
    }
    
    func setRandomTheme() {
        guard let colorTheme = ColorTheme.allCases.randomElement() else { return }
        ColorThemeManager.colorTheme = colorTheme
    }
}


