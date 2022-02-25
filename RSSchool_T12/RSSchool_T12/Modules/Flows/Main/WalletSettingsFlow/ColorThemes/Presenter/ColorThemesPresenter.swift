//
//  ColorThemesPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class ColorThemesPresenter: ColorThemesViewOutput, ColorThemesModuleInput, ColorThemesModuleOutput {
    
    // MARK: - ColorThemesModuleOutput
    
    var didDismissWithTheme: Closure<ColorTheme>?
    
    // MARK: - Properties
    
    weak var view: ColorThemesViewInput?

    // MARK: - Private properties
    
    private let colorThemeManager: ColorThemeManagerProtocol
    private let colorThemes: [ColorTheme]
    private var selectedColorTheme: ColorTheme
    
    // MARK: - Initialization and deinitialization
    
    init(themeManager: ColorThemeManagerProtocol) {
        self.colorThemeManager = themeManager
        colorThemes = ColorTheme.allCases
        selectedColorTheme = themeManager.getTheme()
    }

    // MARK: - ColorThemesViewOutput

    func viewLoaded() {
        view?.setupInitialState()
        
        //getting actual selected colorTheme index
        let selectedColorThemeIndex = colorThemes.firstIndex(of: selectedColorTheme)
        view?.setup(items: colorThemes, with: selectedColorThemeIndex!)
    }
    
    func leftNavigationBarButtonTapped() {
        didDismissWithTheme?(selectedColorTheme)
    }
    
    func didSelectColorTheme(with index: Int) {
        selectedColorTheme = colorThemes[index]
        colorThemeManager.setTheme(selectedColorTheme)
        view?.updateBackground()
    }

    // MARK: - ColorThemesModuleInput

}
