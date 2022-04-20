//
//  CreateWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 18/01/2022.
//  Copyright © 2022 Evgeniy Petlitskiy. All rights reserved.
//

final class CreateWalletPresenter: WalletSettingsViewOutput, CreateWalletModuleOutput {
    
    // MARK: - CreateWalletModuleOutput
    
    var showColorThemeList: CompletionBlock?
    var showCurrencyList: Closure<String>?
    var didDismiss: CompletionBlock?
    var didGetFillRequiredFieldsWarning: CompletionBlock?
    var didShowNameUsedWarning: CompletionBlock?
    var didShowCreateWalletMessage: CompletionBlock?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?
    
    
    // MARK: - Private properties
    
    private let dataStoreManager: DataStoreProtocol
    
    private var walletViewModel: WalletSettingsViewModel
    
    
    // MARK: - Initialization and deinitialization
    
    init(dataStoreManager: DataStoreProtocol) {
        self.dataStoreManager = dataStoreManager
        
        let theme = ColorThemeManager.shared.getTheme()
        let localCurrency = Currency.localCode()
        
        walletViewModel = WalletSettingsViewModel(colorTheme: theme, currencyCode: localCurrency, title: "")
    }
}

// MARK: - ModuleInput

extension CreateWalletPresenter: WalletSettingsModuleInput, CreateWalletModuleInput {
    
    func set(currency: String) {
        walletViewModel.currencyCode = currency
        view?.updateView(with: walletViewModel)
    }
    
    func set(theme: ColorTheme) {
        walletViewModel.colorTheme = theme
        //here we don't need to update the view because of color theme updates for all ThemeView automatically (look at ColorThemeManager)
    }
    
    func saveWallet() {
        dataStoreManager.createNewWallet(from: walletViewModel)
    }
}

// MARK: - WalletSettingsViewOutput

extension CreateWalletPresenter {

    func viewLoaded() {
        view?.setupNewWalletInitialState(with: "Add new wallet")
        view?.updateView(with: walletViewModel)
    }
    
    func leftNavigationBarButtonTapped() {
        
        //all fields on screen except titleField filled by default
        if walletViewModel.title.count == 0 {
            didGetFillRequiredFieldsWarning?()
            return
        }
        
        //ask data store if title is unique
        if dataStoreManager.doesWalletTitleExists(walletViewModel.title) {
            didShowNameUsedWarning?()
            return
        }
        
        //if we don't get any warning we get a suggestion to create a wallet
        didShowCreateWalletMessage?()
    }
    
    func rightNavigationBarButtonTapped() {
        //there is no right button
    }
    
    func didTapOnColorThemePanel() {
        showColorThemeList?()
    }
    
    func didTapOnCurrencyPanel() {
        showCurrencyList?(walletViewModel.currencyCode)
    }
    
    func titleDidUpdate(_ string: String) {
        walletViewModel.title = string
    }
}
