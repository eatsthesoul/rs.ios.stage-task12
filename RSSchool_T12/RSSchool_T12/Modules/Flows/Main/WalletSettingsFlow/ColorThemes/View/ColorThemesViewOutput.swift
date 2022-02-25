//
//  ColorThemesViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 26/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol ColorThemesViewOutput {
    func viewLoaded() // Notify presenter that view is ready
    func leftNavigationBarButtonTapped()
    func didSelectColorTheme(with index: Int)
}
