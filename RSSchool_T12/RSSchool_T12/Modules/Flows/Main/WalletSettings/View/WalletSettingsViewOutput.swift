//
//  WalletSettingsViewOutput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletSettingsViewOutput {
    func viewLoaded()
    func leftNavigationBarButtonTapped()
    func rightNavigationBarButtonTapped()
    func didTapOnColorThemePanel()
    func didTapOnCurrencyPanel()
}
