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
    var didGetFillRequiredFieldsWarning: CompletionBlock?
    var didNameUsedWarning: CompletionBlock?
    var didCreateWalletMessage: CompletionBlock?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?
    var dataStoreManager: DataStoreProtocol
    var colorThemeManager: ColorThemeManagerProtocol
    
    // MARK: - Private properties
    
    private var currentCurrency: String {
        willSet {
            //update currency on the view
            view?.set(currency: newValue)
        }
    }
    
    private var title: String
    
    
    // MARK: - Initialization and deinitialization
    
    init(dataStoreManager: DataStoreProtocol, themeManager: ColorThemeManagerProtocol) {
        self.dataStoreManager = dataStoreManager
        colorThemeManager = themeManager
        currentCurrency = Currency.localCode()
        title = ""
    }
}

// MARK: - CreateWalletModuleInput
extension CreateWalletPresenter {
    
    func set(currency: String) {
        currentCurrency = currency
    }
    
    func saveWallet() {
        let colorTheme = colorThemeManager.getTheme() ?? .goldenHour
        let walletModel = WalletSettingsViewModel(colorTheme: colorTheme,
                                                  currencyCode: currentCurrency,
                                                  title: title)
        dataStoreManager.createNewWallet(from: walletModel)    
    }
}

// MARK: - WalletSettingsViewOutput
extension CreateWalletPresenter {

    func viewLoaded() {
        view?.setupNewWalletInitialState(with: "Add new wallet")
        view?.set(currency: currentCurrency)
    }
    
    func leftNavigationBarButtonTapped() {
        
        //all fields on screen except titleField filled by default
        if title.count == 0 {
            didGetFillRequiredFieldsWarning?()
            return
        }
        
        //ask data store if title is unique
        if dataStoreManager.doesWalletTitleExists(title) {
            didNameUsedWarning?()
            return
        }
        
        //if we don't get any warning we get suggestion to create wallet
        didCreateWalletMessage?()
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
    
    func titleDidUpdate(_ string: String) {
        title = string
    }
}
