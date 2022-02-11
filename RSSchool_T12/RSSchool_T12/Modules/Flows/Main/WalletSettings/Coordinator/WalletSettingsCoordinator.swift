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
            //TODO: - add method for wallet editing
        }
        else {
            showCreateWallet()
        }
    }
}

// MARK: - Private methods

private extension WalletSettingsCoordinator {
    
    func showCreateWallet() {
        let walletSettingsConfigurator = WalletSettingsModuleConfigurator()
        let (view, input, output) = walletSettingsConfigurator.configure()
        
        output.showColorThemeList = { [weak self] in
            self?.showColorThemeList()
        }
        
        output.showCurrencyList = { [weak self, weak input] selectedCurrency in
            self?.showCurrencyList(with: selectedCurrency, input: input)
        }
        
        output.didGetFillRequiredFieldsWarning = { [weak self] in
            self?.showFillRequiredFieldsWarning()
        }
        
        output.didNameUsedWarning = { [weak self] in
            self?.showWalletNameUsedWarning()
        }
        
        output.didCreateWalletMessage = { [weak self] in
            self?.showCreateWalletMessage(completion: { [weak self, weak input] answer in
                if answer {    //save wallet if we get positive response from message
                    input?.saveWallet()
                    self?.finishFlow?()
                }
            })
        }
        
        router.push(view)
    }
    
    func showColorThemeList() {
        let colorThemeCongifurator = ColorThemesModuleConfigurator()
        let (view, output) = colorThemeCongifurator.configure()
        output.didDismiss = { [weak self] in
            self?.router.popModule(animated: true)
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
    
    // MARK: - Alerts
    
    func showFillRequiredFieldsWarning() {
        
        let alertService = AlertService()
        let alert = alertService.walletRequiredFieldsAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.finishFlow?()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    func showWalletNameUsedWarning() {
        
        let alertService = AlertService()
        let alert = alertService.walletNameIsExistAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            self?.finishFlow?()
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
        } rightButtonAction: { [weak self] in
            completion(false)
            self?.router.dismissModule()
        }
        
        router.present(alert, animated: true, completion: nil)
    }
}