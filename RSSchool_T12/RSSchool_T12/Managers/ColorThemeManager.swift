//
//  ColorThemeManager.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18.01.22.
//

import UIKit

protocol ColorThemeManagerProtocol {
    func getTheme() -> ColorTheme
    func setTheme(_ theme: ColorTheme)
    func setRandomTheme()
}

class ColorThemeManager: ColorThemeManagerProtocol {
    
    private static var colorTheme: ColorTheme? {
        didSet {
            //it updates images of all existing and future created ThemeView objects in application
            ThemeView.appearance().image = colorTheme?.image
        }
    }
    
    func getTheme() -> ColorTheme {
        if let theme = ColorThemeManager.colorTheme { return theme }
        else {
            setRandomTheme()
            return ColorThemeManager.colorTheme!
        }
            
    }
    
    func setTheme(_ theme: ColorTheme) {
        ColorThemeManager.colorTheme = theme
    }
    
    func setRandomTheme() {
        guard let colorTheme = ColorTheme.allCases.randomElement() else { return }
        ColorThemeManager.colorTheme = colorTheme
    }
}


