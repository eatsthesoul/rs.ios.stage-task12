//
//  WalletSettingsViewInput.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

protocol WalletSettingsViewInput: AnyObject {
    func setupNewWalletInitialState(with title: String)
    func setupEditWalletInitialState(with title: String)
    func updateView(with wallet: WalletSettingsViewModel)
}
