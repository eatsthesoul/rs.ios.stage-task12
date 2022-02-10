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
            self?.router.dismissModule(animated: true, completion: nil)
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
            //TODO: pop a module next under the warning
        }
        
        router.present(alert, animated: true, completion: nil)
    }
    
    func showWalletNameUsedWarning() {
        let alertService = AlertService()
        let alert = alertService.walletNameIsExistAlert { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
        } rightButtonAction: { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
            //TODO: pop a module next under the warning
        }

        router.present(alert, animated: true, completion: nil)
    }
}
