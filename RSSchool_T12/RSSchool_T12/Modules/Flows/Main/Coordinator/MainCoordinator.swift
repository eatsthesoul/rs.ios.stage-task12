//
//  MainCoordinator.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 10.01.22.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let router: Routable
    
    init(router: Routable) {
        self.router  = router
    }
}

// MARK: - Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        showCreateWallet()
    }
}

// MARK: - Private methods

private extension MainCoordinator {
    
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
            self?.showCreateWalletMessage(completion: { [weak input] answer in
                if answer {    //save wallet if we get positive response from message
                    input?.saveWallet()
                }
            })
        }
        
        router.setNavigationControllerRootModule(view, hideBar: true)
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
            //TODO: pop a module next under the warning
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    func showWalletNameUsedWarning() {
        
        let alertService = AlertService()
        let alert = alertService.walletNameIsExistAlert { [weak self] in
            self?.router.dismissModule()
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule()
            //TODO: pop a module next under the warning
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
