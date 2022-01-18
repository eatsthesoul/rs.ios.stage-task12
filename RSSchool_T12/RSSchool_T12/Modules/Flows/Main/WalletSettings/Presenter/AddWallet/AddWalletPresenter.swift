//
//  AddWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class AddWalletPresenter: WalletSettingsViewOutput, AddWalletModuleInput, AddWalletModuleOutput {

    // MARK: - AddWalletModuleOutput

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?

    // MARK: - AddWalletViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - AddWalletModuleInput

}
