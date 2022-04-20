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
    
    private var colorTheme: ColorTheme? {
        didSet {
            //it updates images of all existing and future created ThemeView objects in application
            ThemeView.appearance().image = colorTheme?.image
        }
    }
    
    // MARK: - Singleton
    
    static let shared = ColorThemeManager()
    
    // MARK: - Initialization and deinitialization
    
    private init() {
        
    }
    
    //MARK: - ColorThemeManagerProtocol
    
    func getTheme() -> ColorTheme {
        if let theme = colorTheme { return theme }
        else {
            setRandomTheme()
            return colorTheme!
        }
    }
    
    func setTheme(_ theme: ColorTheme) {
        colorTheme = theme
    }
    
    func setRandomTheme() {
        guard let colorTheme = ColorTheme.allCases.randomElement() else { return }
        self.colorTheme = colorTheme
    }
}


