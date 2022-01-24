//
//  CreateWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CreateWalletPresenter: WalletSettingsViewOutput, CreateWalletModuleInput, CreateWalletModuleOutput {

    // MARK: - CreateWalletModuleOutput
    
    var showColorThemeList: CompletionBlock?
    var showCurrencyList: CompletionBlock?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?

    // MARK: - CreateWalletModuleInput

}

// MARK: - WalletSettingsViewOutput
extension CreateWalletPresenter {

    func viewLoaded() {
        view?.setupInitialState(for: .create)
    }
    
    func leftNavigationBarButtonTapped() {
        
    }
    
    func rightNavigationBarButtonTapped() {
        //there is no right button
    }
    
    func didTapOnColorThemePanel() {
        showColorThemeList?()
    }
    
    func didTapOnCurrencyPanel() {
        showCurrencyList?()
    }
}
