//
//  ColorThemesViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 26/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol ColorThemesViewInput: AnyObject {
    /// Method for setup initial state of view
    func setupInitialState()
    func setup(items: [ColorTheme], with selectedIndex: Int)
    func updateBackground()
}
