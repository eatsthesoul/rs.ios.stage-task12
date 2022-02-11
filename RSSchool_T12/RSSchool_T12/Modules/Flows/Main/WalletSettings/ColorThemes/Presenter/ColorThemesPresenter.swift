//
//  ColorThemesPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class ColorThemesPresenter: ColorThemesViewOutput, ColorThemesModuleInput, ColorThemesModuleOutput {
    
    // MARK: - ColorThemesModuleOutput
    
    var didDismiss: CompletionBlock?

    // MARK: - Properties

    let colorThemes = ColorTheme.allCases
    weak var view: ColorThemesViewInput?
    
    let colorThemeManager = ColorThemeManager()

    // MARK: - ColorThemesViewOutput

    func viewLoaded() {
        view?.setupInitialState()
        
        let selectedColorTheme = colorThemeManager.getTheme()
        let selectedColorThemeIndex = colorThemes.firstIndex(of: selectedColorTheme!)
        
        view?.setup(items: colorThemes, with: selectedColorThemeIndex!)
    }
    
    func leftNavigationBarButtonTapped() {
        didDismiss?()
    }
    
    func selectedColorTheme(with index: Int) {
        colorThemeManager.setTheme(colorThemes[index])
        view?.updateBackground()
    }

    // MARK: - ColorThemesModuleInput

}
