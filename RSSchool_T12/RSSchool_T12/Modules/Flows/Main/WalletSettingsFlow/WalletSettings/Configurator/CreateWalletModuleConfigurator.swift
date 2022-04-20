//
//  CreateWalletModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

import UIKit

final class CreateWalletModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (WalletSettingsViewController, WalletSettingsModuleInput, CreateWalletModuleInput, CreateWalletModuleOutput) {
        
        let view = WalletSettingsViewController(nibName: "WalletSettingsViewController", bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let presenter = CreateWalletPresenter(dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter, presenter)
    }
}
