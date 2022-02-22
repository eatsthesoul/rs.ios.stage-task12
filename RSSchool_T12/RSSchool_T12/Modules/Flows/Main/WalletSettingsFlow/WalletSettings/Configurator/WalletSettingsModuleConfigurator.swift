//
//  WalletSettingsModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class WalletSettingsModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (WalletSettingsViewController, WalletSettingsModuleInput,  WalletSettingsModuleOutput) {
        let view = WalletSettingsViewController(nibName: "WalletSettingsViewController", bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let colorThemeManager = ColorThemeManager()
        let presenter = CreateWalletPresenter(dataStoreManager: dataStoreManager,
                                              themeManager: colorThemeManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }

}
