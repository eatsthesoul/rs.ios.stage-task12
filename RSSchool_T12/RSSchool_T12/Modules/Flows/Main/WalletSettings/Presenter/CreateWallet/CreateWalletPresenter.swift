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
    var showCurrencyList: Closure<String>?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?
    
    // MARK: - Private properties
    
    private let currentCurrency = Currency.localCode()

    // MARK: - CreateWalletModuleInput

}

// MARK: - WalletSettingsViewOutput
extension CreateWalletPresenter {

    func viewLoaded() {
        view?.setupNewWalletInitialState(with: "Add new wallet", currency: currentCurrency)
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
        showCurrencyList?(currentCurrency)
    }
}
