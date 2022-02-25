//
//  EditWalletPresenter.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.02.22.
//

import Foundation

final class EditWalletPresenter: EditWalletModuleOutput {
    
    // MARK: - EditWalletModuleOutput
    
    var showColorThemeList: CompletionBlock?
    var showCurrencyList: Closure<String>?
    var didDismiss: CompletionBlock?
    var didShowEditWalletMessage: CompletionBlock?
    var didGetFillRequiredFieldsWarning: CompletionBlock?
    var didShowNameUsedWarning: CompletionBlock?
    var didShowDeleteWalletMessage: CompletionBlock?

    // MARK: - Properties

    weak var view: WalletSettingsViewInput?
    
    // MARK: - Private properties
    
    private let dataStoreManager: DataStoreProtocol
    private let colorThemeManager: ColorThemeManagerProtocol
    
    //immutable and then used for comparison as initial wallet
    private let wallet: Wallet
    //it is a view model we are working with. It take all changes from view
    private var walletViewModel: WalletSettingsViewModel
    
    
    
    // MARK: - Initialization and deinitialization
    
    init(wallet: Wallet, dataStoreManager: DataStoreProtocol, themeManager: ColorThemeManagerProtocol) {
        
        self.wallet = wallet
        self.dataStoreManager = dataStoreManager
        colorThemeManager = themeManager
        
        walletViewModel = WalletSettingsViewModel(wallet)
    }
}

// MARK: - ModuleInput

extension EditWalletPresenter: WalletSettingsModuleInput, EditWalletModuleInput {
    
    func set(currency: String) {
        walletViewModel.currencyCode = currency
        view?.updateView(with: walletViewModel)
    }
    
    func set(theme: ColorTheme) {
        walletViewModel.colorTheme = theme
        //here we don't need to update the view because of color theme updates for all ThemeView automatically (look at ColorThemeManager)
    }
    
    func editWallet() {
        
        // all fields on screen except titleField filled by default
        if walletViewModel.title.count == 0 {
            didGetFillRequiredFieldsWarning?()
            return
        }
        
        //ask data store if title is unique
        if dataStoreManager.doesWalletTitleExists(walletViewModel.title), wallet.title != walletViewModel.title {
            didShowNameUsedWarning?()
            return
        }
        
        //if there is no error, update wallet
        dataStoreManager.updateWallet(wallet, with: walletViewModel)
        //and close module
        didDismiss?()
    }
    
    func deleteWallet() {
        dataStoreManager.deleteWallet(wallet)
    }
}

// MARK: - WalletSettingsViewOutput

extension EditWalletPresenter: WalletSettingsViewOutput {

    func viewLoaded() {
        view?.setupEditWalletInitialState(with: "Edit Wallet")
        view?.updateView(with: walletViewModel)
    }
    
    func leftNavigationBarButtonTapped() {
        
        // If there are changes in walletViewModel, we show alert offering to edit wallet
        let notChangedWalletViewModel = WalletSettingsViewModel(wallet)

        if notChangedWalletViewModel != walletViewModel {
            didShowEditWalletMessage?()
        }
        else { //if no, just close module
            didDismiss?()
        }
    }
    
    func rightNavigationBarButtonTapped() {
        didShowDeleteWalletMessage?()
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
