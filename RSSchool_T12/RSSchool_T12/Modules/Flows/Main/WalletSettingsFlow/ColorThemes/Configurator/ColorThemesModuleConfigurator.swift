//
//  ColorThemesModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class ColorThemesModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (ColorThemesViewController, ColorThemesModuleOutput) {
        let view = ColorThemesViewController()
        
        let themeManager = ColorThemeManager()
        let presenter = ColorThemesPresenter(themeManager: themeManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
