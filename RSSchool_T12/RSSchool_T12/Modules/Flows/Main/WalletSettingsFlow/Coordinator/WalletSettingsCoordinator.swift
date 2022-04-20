//
//  WalletSettingsCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import Foundation

import UIKit

final class WalletSettingsCoordinator: BaseCoordinator, WalletSettingsCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    var finishFlowWithDeletingWallet: CompletionBlock?
    
    fileprivate let router: Routable
    fileprivate let wallet: Wallet?
    
    init(router: Routable, wallet: Wallet? = nil) {
        self.router = router
        self.wallet = wallet
    }
}

// MARK: - Coordinatable
extension WalletSettingsCoordinator: Coordinatable {
    func start() {
        if wallet != nil {
            showEditWallet(wallet: wallet!)
        }
        else {
            showCreateWallet()
        }
    }
}

// MARK: - Private methods

private extension WalletSettingsCoordinator {
    
    func showEditWallet(wallet: Wallet) {
        
        let editWalletConfigurator = EditWalletModuleConfigurator()
        let (view, settingsInput, input, output) = editWalletConfigurator.configure(with: wallet)
        
        output.showColorThemeList = { [weak self, weak settingsInput] in
            guard let settingsInput = settingsInput else { return }
            self?.showColorThemeList(input: settingsInput)
        }
        
        output.showCurrencyList = { [weak self, weak settingsInput] selectedCurrency in
            self?.showCurrencyList(with: selectedCurrency, input: settingsInput)
        }
        
        output.didDismiss = dismissModule
        
        output.didShowEditWalletMessage = { [weak self, weak input] in
            self?.showEditWalletMessage(completion: { answer in
                if answer { input?.editWallet() }
            })
        }
        
        output.didGetFillRequiredFieldsWarning = showFillRequiredFieldsWarning
        
        output.didShowNameUsedWarning = showWalletNameUsedWarning
        
        output.didShowDeleteWalletMessage = { [weak self, weak input] in
            self?.showDeleteWalletMessage(completion: { answer in
                if answer {
                    input?.deleteWallet()
                    self?.router.popToRootModule(animated: true)
                    self?.finishFlowWithDeletingWallet?()
                }
            })
        }
        
        router.push(view)
    }
    
    func showCreateWallet() {
        
        let createWalletConfigurator = CreateWalletModuleConfigurator()
        let (view, settingsInput, input, output) = createWalletConfigurator.configure()
        
        output.showColorThemeList = { [weak self, weak settingsInput] in
            guard let settingsInput = settingsInput else { return }
            self?.showColorThemeList(input: settingsInput)
        }
        
        output.showCurrencyList = { [weak self, weak settingsInput] selectedCurrency in
            self?.showCurrencyList(with: selectedCurrency, input: settingsInput)
        }
        
        output.didDismiss = dismissModule
        
        output.didShowCreateWalletMessage = { [weak self, weak input] in
            self?.showCreateWalletMessage(completion: { answer in
                if answer {    //save wallet if we get positive response from message
                    input?.saveWallet()
                }
            })
        }
        
        output.didGetFillRequiredFieldsWarning = showFillRequiredFieldsWarning
        
        output.didShowNameUsedWarning = showWalletNameUsedWarning
        
        router.push(view)
    }
    
    func showColorThemeList(input: WalletSettingsModuleInput) {
        
        let colorThemeCongifurator = ColorThemesModuleConfigurator()
        let (view, output) = colorThemeCongifurator.configure()
        
        output.didDismissWithTheme = { [weak self, weak input] theme in
            input?.set(theme: theme)
            self?.router.popModule()
        }
        
        router.push(view, animated: true)
    }
    
    func showCurrencyList(with selectedCurrency: String, input: WalletSettingsModuleInput?) {
        
        let currencyListConfigurator = CurrencyListModuleConfigurator()
        let (view, output) = currencyListConfigurator.configure(with: selectedCurrency)
        
        output.didDismissWithCurrency = { [weak self, weak input] currency in
            self?.router.popModule(animated: true)
            input?.set(currency: currency)
        }
        
        router.push(view, animated: true)
    }
    
    func dismissModule() {
        router.popModule()
        finishFlow?()
    }
    
    // MARK: - Alerts
    
    func showFillRequiredFieldsWarning() {
        
        let alertService = AlertService()
        let alert = alertService.walletRequiredFieldsAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    func showWalletNameUsedWarning() {
        
        let alertService = AlertService()
        let alert = alertService.walletNameIsExistAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.dismissModule()
        }

        router.present(alert, animated: true, completion: nil)
    }
    
    //completion here to say what answer we get from this message
    func showCreateWalletMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.createNewWalletAlert { [weak self] in
            //completion here for creating a wallet
            completion(true)
            self?.router.dismissModule()
            self?.dismissModule()
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
            self?.dismissModule()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    //completion here to say what answer we get from this message
    func showEditWalletMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.editWalletAlert { [weak self] in
            self?.router.dismissModule(animated: true, completion: {
                //if true, we need to edit wallet
                completion(true)
            })
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
            self?.dismissModule()
        }
        completion(false)
        router.present(alert, animated: true, completion: nil)
    }
    
    
    //completion here to say what answer we get from this message
    func showDeleteWalletMessage(completion: @escaping Closure<Bool>) {
        
        let alertService = AlertService()
        let alert = alertService.deleteWalletAlert { [weak self] in
            self?.router.dismissModule(animated: true, completion: {
                //if true, we need to delete wallet
                completion(true)
            })
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
}
