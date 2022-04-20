//
//  EditWalletModuleConfigurator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.02.22.
//

import UIKit

final class EditWalletModuleConfigurator {

    // MARK: - Internal methods

    func configure(with wallet: Wallet) -> (WalletSettingsViewController, WalletSettingsModuleInput, EditWalletModuleInput, EditWalletModuleOutput) {
        
        let view = WalletSettingsViewController(nibName: "WalletSettingsViewController", bundle: nil)
        
        let dataStoreManager = DataStoreManager.shared
        let presenter = EditWalletPresenter(wallet: wallet,
                                              dataStoreManager: dataStoreManager)

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter, presenter)
    }

}
