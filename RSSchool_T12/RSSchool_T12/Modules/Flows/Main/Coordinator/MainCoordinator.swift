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
        let (view, output) = walletSettingsConfigurator.configure()
        output.showColorThemeList = { [weak self] in
            self?.showColorThemeList()
        }
        output.showCurrencyList = { [weak self] in
            self?.showCurrencyList()
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
    
    func showCurrencyList() {
        let currencyListConfigurator = CurrencyListModuleConfigurator()
        let (view, output) = currencyListConfigurator.configure()
        
        router.push(view, animated: true)
    }
}
