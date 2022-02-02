//
//  CreateWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CreateWalletPresenter: WalletSettingsViewOutput, WalletSettingsModuleInput, WalletSettingsModuleOutput {
    
    // MARK: - CreateWalletModuleOutput
    
    var showColorThemeList: CompletionBlock?
    var showCurrencyList: Closure<String>?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?
    
    // MARK: - Private properties
    
    private var currentCurrency: String {
        willSet {
            //update currency on the view
            view?.set(currency: newValue)
        }
    }
    
    init() {
        currentCurrency = Currency.localCode()
    }
}

// MARK: - CreateWalletModuleInput
extension CreateWalletPresenter {
    func set(currency: String) {
        currentCurrency = currency
    }
}

// MARK: - WalletSettingsViewOutput
extension CreateWalletPresenter {

    func viewLoaded() {
        view?.setupNewWalletInitialState(with: "Add new wallet")
        view?.set(currency: currentCurrency)
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
